//
//  TableViewController.m
//  WeatherParsing
//
//  Created by Harshad on 27/08/16.
//  Copyright (c) 2016 Harshad. All rights reserved.
//

#import "TableViewController.h"
#import "Weather.h"
#import "CustomCell.h"
#import "Weather2.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
   self.title = @"Weather Parsing";
    _weatherArray = [NSMutableArray new];
   // _weatherArray2 = [NSMutableArray new];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"weather" withExtension:@"json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
{
        
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@",dic);
    NSDictionary *innerDic = [dic objectForKey:@"data"];
    NSArray *result = [innerDic objectForKey:@"current_condition"];
    NSArray *result2 = [innerDic objectForKey:@"request"];
    
    for(NSDictionary *temp in result)
      {
        Weather *w1 = [[Weather alloc]init];
        w1.cloud = [temp objectForKey:@"cloudcover"];
        w1.humidity = [temp objectForKey:@"humidity"];
        w1.time = [temp objectForKey:@"observation_time"];
        w1.weathercode = [temp objectForKey:@"weatherCode"];
        w1.wind = [temp objectForKey:@"winddir16Point"];
        w1.windDegree = [temp objectForKey:@"winddirDegree"];
        
        NSArray *innerArray = [temp objectForKey:@"weatherDesc"];
        NSLog(@"%@ %@ %@ %@ %@ ",[temp objectForKey:@"cloudcover"],
              [temp objectForKey:@"humidity"],[temp objectForKey:@"observation_time"],[temp objectForKey:@"weatherCode"],[temp objectForKey:@"weatherDesc"]);
          
        for (NSDictionary *temp1 in innerArray)
        {
          w1.value = [temp1 objectForKey:@"value"];
          NSLog(@"%@",[temp1 objectForKey:@"value"]);
        }
          
        NSArray *innerArray2 = [temp objectForKey:@"weatherIconUrl"];
          for (NSDictionary *temp2 in innerArray2)
          {
            _url1=[NSURL URLWithString:[temp2 objectForKey:@"value"]];
            [_weatherArray addObject:w1];
              
          }
          for(NSDictionary *temp3 in result2)
          {
           //   Weather2 *w2 = [[Weather2 alloc]init];
              
               w1.query =  [temp3 objectForKey:@"query"];
               w1.type =  [temp3 objectForKey:@"type"];
           //   [_weatherArray2 addObject:w2];

          }
          [self.tableView reloadData];
        }
}];
    [task resume];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
      return _weatherArray.count;
    }
    else if(section==1)
    {
        return _weatherArray2.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Weather *temp = [_weatherArray objectAtIndex:indexPath.row];
    
    cell.lbl1.text = temp.cloud;
    cell.lbl2.text = temp.humidity;
    cell.lbl3.text = temp.time;
    cell.lbl4.text = temp.value;
    cell.lbl5.text = temp.weathercode;
    cell.lbl6.text = temp.wind;
    cell.lbl7.text = temp.windDegree;
  
    NSData *data=[NSData dataWithContentsOfURL:_url1];
    cell.icon.image=[UIImage imageWithData:data];
    cell.lbl9.text = temp.query;
    cell.lbl8.text = temp.type;
   
   UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 1.0, cell.contentView.frame.size.width, 1)];
   lineView.backgroundColor = [UIColor darkGrayColor];
   [cell.contentView addSubview:lineView];
   
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
