use crate::services::doc::extensions::DeleteExt;
use flowy_ot::core::{Delta, DeltaBuilder, Interval};

pub struct DefaultDelete {}
impl DeleteExt for DefaultDelete {
    fn ext_name(&self) -> &str { "DefaultDelete" }

    fn apply(&self, _delta: &Delta, interval: Interval) -> Option<Delta> {
        Some(
            DeltaBuilder::new()
                .retain(interval.start)
                .delete(interval.size())
                .build(),
        )
    }
}
