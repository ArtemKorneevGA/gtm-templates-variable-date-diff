# Days, Hours or Minutes Between Two Dates (or Now) – Custom Variable Template

The Custom Variable Template to get the amount of full days, hours, etc. between the first and the second date or Date.now().

![Days, Hours or Minutes Between Two Dates (or Now)](https://gtm-gear.com/images/2022/04/diff-time.png)

## Description

The variable template can help you to build triggers in which you need to compare a date of a previous event with the current date. The date of previous event should be in [Unix Time](https://en.wikipedia.org/wiki/Unix_time), result of [Date.now()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/now).

## Set Up

- Go to Templates Page;
- Click **Search Gallery** in Variable Templates section;
- Type **Days, Hours or Minutes Between Two Dates**. In the list of templates click on the template;
- Click **Add to workspace** button;
- Go to Variables page;
- Click **Add** button, select the template from the list;
- Set variable name;
- Set value for **First Date** field. Usually it's GTM variable contains [Unix Time](https://en.wikipedia.org/wiki/Unix_time). For example it can be a **1st Party Cookie GTM Variable** with the name **cookie.previous_event_time**. Put the name of the variable like this **{{cookie.previous_event_time}}**;
- If you need to compare with the current time set the **Compare to** to **Now**. If you need to compare with a second date, select **Other date** and put the date or GTM Variable with the date in **Second date** field;
- Set the **Time Unit**, by default it sets to **Days**. But if you need to compare dates in hours, minutes or seconds – please change **Time Unit** filed;
- Click **Save** button;
- Now you can use the new variable in triggers and compare the value using **greater than** or **less than** operators with a needed amount of days (or other time units based on your setup).

## Use Cases

- Create trigger on login event but X days after registrations
- Create trigger on purchase event in the same day as previous purchase
- Create trigger on purchase event but not less than X days after visiting blog
