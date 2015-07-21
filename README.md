# ZJYTableViewCell
A table view cell with different custom styles, for iOS. 

- ZJYTableViewCellNone
- ZJYTableViewCellDefault

============

## ZJYTableViewCellNone

 - Header line (for first cell in section)
 - Footer line (for last cell in section)
 - Separator line
 - Nothing else.

============

## ZJYTableViewCellDefault

A simple cell, including a title label, an optional remind text and an optional accessory view. The text, font, color, margin to screen of both labels can be edited.


### Sample

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    ZJYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZJYTableViewCell alloc] initWithZJYStyle:ZJYTableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.title = @"Nothing";
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryNone;
            cell.isFirstCell = YES;
            break;
        case 1:
            cell.title = @"Remind text";
            cell.remindText = @"Warning!";
            cell.colorOfRemindText = [UIColor redColor];
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.title = @"Colored title and different left margin";
            cell.colorOfTitle = [UIColor greenColor];
            cell.leftMarginOfTitle = 0 * [[UIScreen mainScreen] scale];
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.title = @"Bigger title";
            cell.colorOfRemindText = [UIColor redColor];
            cell.fontOfTitle = [UIFont systemFontOfSize:15*[[UIScreen mainScreen] scale]];
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryDisclosureIndicator;
            cell.isLastCell = YES;
        default:
            break;
    }
    return cell;
}

```

<p align="center" >
<br/>
<img src="https://raw.githubusercontent.com/bryester/ZJYTableViewCell/master/img/default-style.png" alt="Overview" />
<br/>
</p>

============

## License
RZTransitions is distributed under an [MIT License](http://opensource.org/licenses/MIT). See the LICENSE file for more details.
