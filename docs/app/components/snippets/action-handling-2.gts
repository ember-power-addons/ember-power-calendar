import Component from '@glimmer/component';
import { dropTask, timeout } from 'ember-concurrency';
import { tracked } from '@glimmer/tracking';
import PowerCalendar from 'ember-power-calendar/components/power-calendar';
import type { NormalizeCalendarValue } from 'ember-power-calendar/utils';

export default class extends Component {
  @tracked center: Date | undefined;

  updateMonth = dropTask(async ({ date }: NormalizeCalendarValue) => {
    await timeout(600); // Pretend this is an ajax call to the server...
    // ...and that here we update the events somehow
    this.center = date;
  });

  <template>
    <PowerCalendar
      @center={{this.center}}
      @onCenterChange={{this.updateMonth.perform}}
      as |calendar|
    >
      <div class={{if calendar.loading "loading-spiner-overlay"}}>
        <calendar.Nav />
        <calendar.Days />
      </div>
    </PowerCalendar>
  </template>
}
