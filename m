Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34672 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab2IGQ17 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:59 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 25/31] arm64: Performance counters support
Date: Fri,  7 Sep 2012 17:27:00 +0100
Message-ID: <1347035226-18649-26-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162700.Hk5ZvBK0Iue_P3G6ykVmkjFzvLHSPMzbZXBrUwRC_iE@z>

From: Will Deacon <will.deacon@arm.com>

This patch adds support for the AArch64 performance counters.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/perf_event.h |   22 +
 arch/arm64/include/asm/pmu.h        |   82 +++
 arch/arm64/kernel/perf_event.c      | 1368 +++++++++++++++++++++++++++++++=
++++
 tools/perf/perf.h                   |    6 +
 4 files changed, 1478 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/perf_event.h
 create mode 100644 arch/arm64/include/asm/pmu.h
 create mode 100644 arch/arm64/kernel/perf_event.c

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/p=
erf_event.h
new file mode 100644
index 0000000..a6fffd5
--- /dev/null
+++ b/arch/arm64/include/asm/perf_event.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_PERF_EVENT_H
+#define __ASM_PERF_EVENT_H
+
+/* It's quiet around here... */
+
+#endif
diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
new file mode 100644
index 0000000..e6f0878
--- /dev/null
+++ b/arch/arm64/include/asm/pmu.h
@@ -0,0 +1,82 @@
+/*
+ * Based on arch/arm/include/asm/pmu.h
+ *
+ * Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_PMU_H
+#define __ASM_PMU_H
+
+#ifdef CONFIG_HW_PERF_EVENTS
+
+/* The events for a given PMU register set. */
+struct pmu_hw_events {
+=09/*
+=09 * The events that are active on the PMU for the given index.
+=09 */
+=09struct perf_event=09**events;
+
+=09/*
+=09 * A 1 bit for an index indicates that the counter is being used for
+=09 * an event. A 0 means that the counter can be used.
+=09 */
+=09unsigned long           *used_mask;
+
+=09/*
+=09 * Hardware lock to serialize accesses to PMU registers. Needed for the
+=09 * read/modify/write sequences.
+=09 */
+=09raw_spinlock_t=09=09pmu_lock;
+};
+
+struct arm_pmu {
+=09struct pmu=09=09pmu;
+=09cpumask_t=09=09active_irqs;
+=09const char=09=09*name;
+=09irqreturn_t=09=09(*handle_irq)(int irq_num, void *dev);
+=09void=09=09=09(*enable)(struct hw_perf_event *evt, int idx);
+=09void=09=09=09(*disable)(struct hw_perf_event *evt, int idx);
+=09int=09=09=09(*get_event_idx)(struct pmu_hw_events *hw_events,
+=09=09=09=09=09=09 struct hw_perf_event *hwc);
+=09int=09=09=09(*set_event_filter)(struct hw_perf_event *evt,
+=09=09=09=09=09=09    struct perf_event_attr *attr);
+=09u32=09=09=09(*read_counter)(int idx);
+=09void=09=09=09(*write_counter)(int idx, u32 val);
+=09void=09=09=09(*start)(void);
+=09void=09=09=09(*stop)(void);
+=09void=09=09=09(*reset)(void *);
+=09int=09=09=09(*map_event)(struct perf_event *event);
+=09int=09=09=09num_events;
+=09atomic_t=09=09active_events;
+=09struct mutex=09=09reserve_mutex;
+=09u64=09=09=09max_period;
+=09struct platform_device=09*plat_device;
+=09struct pmu_hw_events=09*(*get_hw_events)(void);
+};
+
+#define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
+
+int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type);
+
+u64 armpmu_event_update(struct perf_event *event,
+=09=09=09struct hw_perf_event *hwc,
+=09=09=09int idx);
+
+int armpmu_event_set_period(struct perf_event *event,
+=09=09=09    struct hw_perf_event *hwc,
+=09=09=09    int idx);
+
+#endif /* CONFIG_HW_PERF_EVENTS */
+#endif /* __ASM_PMU_H */
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.=
c
new file mode 100644
index 0000000..ecbf2d8
--- /dev/null
+++ b/arch/arm64/kernel/perf_event.c
@@ -0,0 +1,1368 @@
+/*
+ * PMU support
+ *
+ * Copyright (C) 2012 ARM Limited
+ * Author: Will Deacon <will.deacon@arm.com>
+ *
+ * This code is based heavily on the ARMv7 perf event code.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#define pr_fmt(fmt) "hw perfevents: " fmt
+
+#include <linux/bitmap.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+
+#include <asm/cputype.h>
+#include <asm/irq.h>
+#include <asm/irq_regs.h>
+#include <asm/pmu.h>
+#include <asm/stacktrace.h>
+
+/*
+ * ARMv8 supports a maximum of 32 events.
+ * The cycle counter is included in this total.
+ */
+#define ARMPMU_MAX_HWEVENTS=09=0932
+
+static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events=
);
+static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], =
used_mask);
+static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
+
+#define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
+
+/* Set at runtime when we know what CPU type we are. */
+static struct arm_pmu *cpu_pmu;
+
+int
+armpmu_get_max_events(void)
+{
+=09int max_events =3D 0;
+
+=09if (cpu_pmu !=3D NULL)
+=09=09max_events =3D cpu_pmu->num_events;
+
+=09return max_events;
+}
+EXPORT_SYMBOL_GPL(armpmu_get_max_events);
+
+int perf_num_counters(void)
+{
+=09return armpmu_get_max_events();
+}
+EXPORT_SYMBOL_GPL(perf_num_counters);
+
+#define HW_OP_UNSUPPORTED=09=090xFFFF
+
+#define C(_x) \
+=09PERF_COUNT_HW_CACHE_##_x
+
+#define CACHE_OP_UNSUPPORTED=09=090xFFFF
+
+static int
+armpmu_map_cache_event(const unsigned (*cache_map)
+=09=09=09=09      [PERF_COUNT_HW_CACHE_MAX]
+=09=09=09=09      [PERF_COUNT_HW_CACHE_OP_MAX]
+=09=09=09=09      [PERF_COUNT_HW_CACHE_RESULT_MAX],
+=09=09       u64 config)
+{
+=09unsigned int cache_type, cache_op, cache_result, ret;
+
+=09cache_type =3D (config >>  0) & 0xff;
+=09if (cache_type >=3D PERF_COUNT_HW_CACHE_MAX)
+=09=09return -EINVAL;
+
+=09cache_op =3D (config >>  8) & 0xff;
+=09if (cache_op >=3D PERF_COUNT_HW_CACHE_OP_MAX)
+=09=09return -EINVAL;
+
+=09cache_result =3D (config >> 16) & 0xff;
+=09if (cache_result >=3D PERF_COUNT_HW_CACHE_RESULT_MAX)
+=09=09return -EINVAL;
+
+=09ret =3D (int)(*cache_map)[cache_type][cache_op][cache_result];
+
+=09if (ret =3D=3D CACHE_OP_UNSUPPORTED)
+=09=09return -ENOENT;
+
+=09return ret;
+}
+
+static int
+armpmu_map_event(const unsigned (*event_map)[PERF_COUNT_HW_MAX], u64 confi=
g)
+{
+=09int mapping =3D (*event_map)[config];
+=09return mapping =3D=3D HW_OP_UNSUPPORTED ? -ENOENT : mapping;
+}
+
+static int
+armpmu_map_raw_event(u32 raw_event_mask, u64 config)
+{
+=09return (int)(config & raw_event_mask);
+}
+
+static int map_cpu_event(struct perf_event *event,
+=09=09=09 const unsigned (*event_map)[PERF_COUNT_HW_MAX],
+=09=09=09 const unsigned (*cache_map)
+=09=09=09=09=09[PERF_COUNT_HW_CACHE_MAX]
+=09=09=09=09=09[PERF_COUNT_HW_CACHE_OP_MAX]
+=09=09=09=09=09[PERF_COUNT_HW_CACHE_RESULT_MAX],
+=09=09=09 u32 raw_event_mask)
+{
+=09u64 config =3D event->attr.config;
+
+=09switch (event->attr.type) {
+=09case PERF_TYPE_HARDWARE:
+=09=09return armpmu_map_event(event_map, config);
+=09case PERF_TYPE_HW_CACHE:
+=09=09return armpmu_map_cache_event(cache_map, config);
+=09case PERF_TYPE_RAW:
+=09=09return armpmu_map_raw_event(raw_event_mask, config);
+=09}
+
+=09return -ENOENT;
+}
+
+int
+armpmu_event_set_period(struct perf_event *event,
+=09=09=09struct hw_perf_event *hwc,
+=09=09=09int idx)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09s64 left =3D local64_read(&hwc->period_left);
+=09s64 period =3D hwc->sample_period;
+=09int ret =3D 0;
+
+=09if (unlikely(left <=3D -period)) {
+=09=09left =3D period;
+=09=09local64_set(&hwc->period_left, left);
+=09=09hwc->last_period =3D period;
+=09=09ret =3D 1;
+=09}
+
+=09if (unlikely(left <=3D 0)) {
+=09=09left +=3D period;
+=09=09local64_set(&hwc->period_left, left);
+=09=09hwc->last_period =3D period;
+=09=09ret =3D 1;
+=09}
+
+=09if (left > (s64)armpmu->max_period)
+=09=09left =3D armpmu->max_period;
+
+=09local64_set(&hwc->prev_count, (u64)-left);
+
+=09armpmu->write_counter(idx, (u64)(-left) & 0xffffffff);
+
+=09perf_event_update_userpage(event);
+
+=09return ret;
+}
+
+u64
+armpmu_event_update(struct perf_event *event,
+=09=09    struct hw_perf_event *hwc,
+=09=09    int idx)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09u64 delta, prev_raw_count, new_raw_count;
+
+again:
+=09prev_raw_count =3D local64_read(&hwc->prev_count);
+=09new_raw_count =3D armpmu->read_counter(idx);
+
+=09if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+=09=09=09     new_raw_count) !=3D prev_raw_count)
+=09=09goto again;
+
+=09delta =3D (new_raw_count - prev_raw_count) & armpmu->max_period;
+
+=09local64_add(delta, &event->count);
+=09local64_sub(delta, &hwc->period_left);
+
+=09return new_raw_count;
+}
+
+static void
+armpmu_read(struct perf_event *event)
+{
+=09struct hw_perf_event *hwc =3D &event->hw;
+
+=09/* Don't read disabled counters! */
+=09if (hwc->idx < 0)
+=09=09return;
+
+=09armpmu_event_update(event, hwc, hwc->idx);
+}
+
+static void
+armpmu_stop(struct perf_event *event, int flags)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09struct hw_perf_event *hwc =3D &event->hw;
+
+=09/*
+=09 * ARM pmu always has to update the counter, so ignore
+=09 * PERF_EF_UPDATE, see comments in armpmu_start().
+=09 */
+=09if (!(hwc->state & PERF_HES_STOPPED)) {
+=09=09armpmu->disable(hwc, hwc->idx);
+=09=09barrier(); /* why? */
+=09=09armpmu_event_update(event, hwc, hwc->idx);
+=09=09hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
+=09}
+}
+
+static void
+armpmu_start(struct perf_event *event, int flags)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09struct hw_perf_event *hwc =3D &event->hw;
+
+=09/*
+=09 * ARM pmu always has to reprogram the period, so ignore
+=09 * PERF_EF_RELOAD, see the comment below.
+=09 */
+=09if (flags & PERF_EF_RELOAD)
+=09=09WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+
+=09hwc->state =3D 0;
+=09/*
+=09 * Set the period again. Some counters can't be stopped, so when we
+=09 * were stopped we simply disabled the IRQ source and the counter
+=09 * may have been left counting. If we don't do this step then we may
+=09 * get an interrupt too soon or *way* too late if the overflow has
+=09 * happened since disabling.
+=09 */
+=09armpmu_event_set_period(event, hwc, hwc->idx);
+=09armpmu->enable(hwc, hwc->idx);
+}
+
+static void
+armpmu_del(struct perf_event *event, int flags)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09struct pmu_hw_events *hw_events =3D armpmu->get_hw_events();
+=09struct hw_perf_event *hwc =3D &event->hw;
+=09int idx =3D hwc->idx;
+
+=09WARN_ON(idx < 0);
+
+=09armpmu_stop(event, PERF_EF_UPDATE);
+=09hw_events->events[idx] =3D NULL;
+=09clear_bit(idx, hw_events->used_mask);
+
+=09perf_event_update_userpage(event);
+}
+
+static int
+armpmu_add(struct perf_event *event, int flags)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09struct pmu_hw_events *hw_events =3D armpmu->get_hw_events();
+=09struct hw_perf_event *hwc =3D &event->hw;
+=09int idx;
+=09int err =3D 0;
+
+=09perf_pmu_disable(event->pmu);
+
+=09/* If we don't have a space for the counter then finish early. */
+=09idx =3D armpmu->get_event_idx(hw_events, hwc);
+=09if (idx < 0) {
+=09=09err =3D idx;
+=09=09goto out;
+=09}
+
+=09/*
+=09 * If there is an event in the counter we are going to use then make
+=09 * sure it is disabled.
+=09 */
+=09event->hw.idx =3D idx;
+=09armpmu->disable(hwc, idx);
+=09hw_events->events[idx] =3D event;
+
+=09hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
+=09if (flags & PERF_EF_START)
+=09=09armpmu_start(event, PERF_EF_RELOAD);
+
+=09/* Propagate our changes to the userspace mapping. */
+=09perf_event_update_userpage(event);
+
+out:
+=09perf_pmu_enable(event->pmu);
+=09return err;
+}
+
+static int
+validate_event(struct pmu_hw_events *hw_events,
+=09       struct perf_event *event)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09struct hw_perf_event fake_event =3D event->hw;
+=09struct pmu *leader_pmu =3D event->group_leader->pmu;
+
+=09if (event->pmu !=3D leader_pmu || event->state <=3D PERF_EVENT_STATE_OF=
F)
+=09=09return 1;
+
+=09return armpmu->get_event_idx(hw_events, &fake_event) >=3D 0;
+}
+
+static int
+validate_group(struct perf_event *event)
+{
+=09struct perf_event *sibling, *leader =3D event->group_leader;
+=09struct pmu_hw_events fake_pmu;
+=09DECLARE_BITMAP(fake_used_mask, ARMPMU_MAX_HWEVENTS);
+
+=09/*
+=09 * Initialise the fake PMU. We only need to populate the
+=09 * used_mask for the purposes of validation.
+=09 */
+=09memset(fake_used_mask, 0, sizeof(fake_used_mask));
+=09fake_pmu.used_mask =3D fake_used_mask;
+
+=09if (!validate_event(&fake_pmu, leader))
+=09=09return -EINVAL;
+
+=09list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+=09=09if (!validate_event(&fake_pmu, sibling))
+=09=09=09return -EINVAL;
+=09}
+
+=09if (!validate_event(&fake_pmu, event))
+=09=09return -EINVAL;
+
+=09return 0;
+}
+
+static void
+armpmu_release_hardware(struct arm_pmu *armpmu)
+{
+=09int i, irq, irqs;
+=09struct platform_device *pmu_device =3D armpmu->plat_device;
+
+=09irqs =3D min(pmu_device->num_resources, num_possible_cpus());
+
+=09for (i =3D 0; i < irqs; ++i) {
+=09=09if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
+=09=09=09continue;
+=09=09irq =3D platform_get_irq(pmu_device, i);
+=09=09if (irq >=3D 0)
+=09=09=09free_irq(irq, armpmu);
+=09}
+}
+
+static int
+armpmu_reserve_hardware(struct arm_pmu *armpmu)
+{
+=09int i, err, irq, irqs;
+=09struct platform_device *pmu_device =3D armpmu->plat_device;
+
+=09if (!pmu_device) {
+=09=09pr_err("no PMU device registered\n");
+=09=09return -ENODEV;
+=09}
+
+=09irqs =3D min(pmu_device->num_resources, num_possible_cpus());
+=09if (irqs < 1) {
+=09=09pr_err("no irqs for PMUs defined\n");
+=09=09return -ENODEV;
+=09}
+
+=09for (i =3D 0; i < irqs; ++i) {
+=09=09err =3D 0;
+=09=09irq =3D platform_get_irq(pmu_device, i);
+=09=09if (irq < 0)
+=09=09=09continue;
+
+=09=09/*
+=09=09 * If we have a single PMU interrupt that we can't shift,
+=09=09 * assume that we're running on a uniprocessor machine and
+=09=09 * continue. Otherwise, continue without this interrupt.
+=09=09 */
+=09=09if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
+=09=09=09pr_warning("unable to set irq affinity (irq=3D%d, cpu=3D%u)\n",
+=09=09=09=09    irq, i);
+=09=09=09continue;
+=09=09}
+
+=09=09err =3D request_irq(irq, armpmu->handle_irq,
+=09=09=09=09  IRQF_NOBALANCING,
+=09=09=09=09  "arm-pmu", armpmu);
+=09=09if (err) {
+=09=09=09pr_err("unable to request IRQ%d for ARM PMU counters\n",
+=09=09=09=09irq);
+=09=09=09armpmu_release_hardware(armpmu);
+=09=09=09return err;
+=09=09}
+
+=09=09cpumask_set_cpu(i, &armpmu->active_irqs);
+=09}
+
+=09return 0;
+}
+
+static void
+hw_perf_event_destroy(struct perf_event *event)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09atomic_t *active_events=09 =3D &armpmu->active_events;
+=09struct mutex *pmu_reserve_mutex =3D &armpmu->reserve_mutex;
+
+=09if (atomic_dec_and_mutex_lock(active_events, pmu_reserve_mutex)) {
+=09=09armpmu_release_hardware(armpmu);
+=09=09mutex_unlock(pmu_reserve_mutex);
+=09}
+}
+
+static int
+event_requires_mode_exclusion(struct perf_event_attr *attr)
+{
+=09return attr->exclude_idle || attr->exclude_user ||
+=09       attr->exclude_kernel || attr->exclude_hv;
+}
+
+static int
+__hw_perf_event_init(struct perf_event *event)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09struct hw_perf_event *hwc =3D &event->hw;
+=09int mapping, err;
+
+=09mapping =3D armpmu->map_event(event);
+
+=09if (mapping < 0) {
+=09=09pr_debug("event %x:%llx not supported\n", event->attr.type,
+=09=09=09 event->attr.config);
+=09=09return mapping;
+=09}
+
+=09/*
+=09 * We don't assign an index until we actually place the event onto
+=09 * hardware. Use -1 to signify that we haven't decided where to put it
+=09 * yet. For SMP systems, each core has it's own PMU so we can't do any
+=09 * clever allocation or constraints checking at this point.
+=09 */
+=09hwc->idx=09=09=3D -1;
+=09hwc->config_base=09=3D 0;
+=09hwc->config=09=09=3D 0;
+=09hwc->event_base=09=09=3D 0;
+
+=09/*
+=09 * Check whether we need to exclude the counter from certain modes.
+=09 */
+=09if ((!armpmu->set_event_filter ||
+=09     armpmu->set_event_filter(hwc, &event->attr)) &&
+=09     event_requires_mode_exclusion(&event->attr)) {
+=09=09pr_debug("ARM performance counters do not support mode exclusion\n")=
;
+=09=09return -EPERM;
+=09}
+
+=09/*
+=09 * Store the event encoding into the config_base field.
+=09 */
+=09hwc->config_base=09    |=3D (unsigned long)mapping;
+
+=09if (!hwc->sample_period) {
+=09=09/*
+=09=09 * For non-sampling runs, limit the sample_period to half
+=09=09 * of the counter width. That way, the new counter value
+=09=09 * is far less likely to overtake the previous one unless
+=09=09 * you have some serious IRQ latency issues.
+=09=09 */
+=09=09hwc->sample_period  =3D armpmu->max_period >> 1;
+=09=09hwc->last_period    =3D hwc->sample_period;
+=09=09local64_set(&hwc->period_left, hwc->sample_period);
+=09}
+
+=09err =3D 0;
+=09if (event->group_leader !=3D event) {
+=09=09err =3D validate_group(event);
+=09=09if (err)
+=09=09=09return -EINVAL;
+=09}
+
+=09return err;
+}
+
+static int armpmu_event_init(struct perf_event *event)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(event->pmu);
+=09int err =3D 0;
+=09atomic_t *active_events =3D &armpmu->active_events;
+
+=09if (armpmu->map_event(event) =3D=3D -ENOENT)
+=09=09return -ENOENT;
+
+=09event->destroy =3D hw_perf_event_destroy;
+
+=09if (!atomic_inc_not_zero(active_events)) {
+=09=09mutex_lock(&armpmu->reserve_mutex);
+=09=09if (atomic_read(active_events) =3D=3D 0)
+=09=09=09err =3D armpmu_reserve_hardware(armpmu);
+
+=09=09if (!err)
+=09=09=09atomic_inc(active_events);
+=09=09mutex_unlock(&armpmu->reserve_mutex);
+=09}
+
+=09if (err)
+=09=09return err;
+
+=09err =3D __hw_perf_event_init(event);
+=09if (err)
+=09=09hw_perf_event_destroy(event);
+
+=09return err;
+}
+
+static void armpmu_enable(struct pmu *pmu)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(pmu);
+=09struct pmu_hw_events *hw_events =3D armpmu->get_hw_events();
+=09int enabled =3D bitmap_weight(hw_events->used_mask, armpmu->num_events)=
;
+
+=09if (enabled)
+=09=09armpmu->start();
+}
+
+static void armpmu_disable(struct pmu *pmu)
+{
+=09struct arm_pmu *armpmu =3D to_arm_pmu(pmu);
+=09armpmu->stop();
+}
+
+static void __init armpmu_init(struct arm_pmu *armpmu)
+{
+=09atomic_set(&armpmu->active_events, 0);
+=09mutex_init(&armpmu->reserve_mutex);
+
+=09armpmu->pmu =3D (struct pmu) {
+=09=09.pmu_enable=09=3D armpmu_enable,
+=09=09.pmu_disable=09=3D armpmu_disable,
+=09=09.event_init=09=3D armpmu_event_init,
+=09=09.add=09=09=3D armpmu_add,
+=09=09.del=09=09=3D armpmu_del,
+=09=09.start=09=09=3D armpmu_start,
+=09=09.stop=09=09=3D armpmu_stop,
+=09=09.read=09=09=3D armpmu_read,
+=09};
+}
+
+int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type)
+{
+=09armpmu_init(armpmu);
+=09return perf_pmu_register(&armpmu->pmu, name, type);
+}
+
+/*
+ * ARMv8 PMUv3 Performance Events handling code.
+ * Common event types.
+ */
+enum armv8_pmuv3_perf_types {
+=09/* Required events. */
+=09ARMV8_PMUV3_PERFCTR_PMNC_SW_INCR=09=09=09=3D 0x00,
+=09ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL=09=09=09=3D 0x03,
+=09ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS=09=09=09=3D 0x04,
+=09ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED=09=09=09=3D 0x10,
+=09ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES=09=09=09=3D 0x11,
+=09ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED=09=09=09=3D 0x12,
+
+=09/* At least one of the following is required. */
+=09ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED=09=09=09=3D 0x08,
+=09ARMV8_PMUV3_PERFCTR_OP_SPEC=09=09=09=09=3D 0x1B,
+
+=09/* Common architectural events. */
+=09ARMV8_PMUV3_PERFCTR_MEM_READ=09=09=09=09=3D 0x06,
+=09ARMV8_PMUV3_PERFCTR_MEM_WRITE=09=09=09=09=3D 0x07,
+=09ARMV8_PMUV3_PERFCTR_EXC_TAKEN=09=09=09=09=3D 0x09,
+=09ARMV8_PMUV3_PERFCTR_EXC_EXECUTED=09=09=09=3D 0x0A,
+=09ARMV8_PMUV3_PERFCTR_CID_WRITE=09=09=09=09=3D 0x0B,
+=09ARMV8_PMUV3_PERFCTR_PC_WRITE=09=09=09=09=3D 0x0C,
+=09ARMV8_PMUV3_PERFCTR_PC_IMM_BRANCH=09=09=09=3D 0x0D,
+=09ARMV8_PMUV3_PERFCTR_PC_PROC_RETURN=09=09=09=3D 0x0E,
+=09ARMV8_PMUV3_PERFCTR_MEM_UNALIGNED_ACCESS=09=09=3D 0x0F,
+=09ARMV8_PMUV3_PERFCTR_TTBR_WRITE=09=09=09=09=3D 0x1C,
+
+=09/* Common microarchitectural events. */
+=09ARMV8_PMUV3_PERFCTR_L1_ICACHE_REFILL=09=09=09=3D 0x01,
+=09ARMV8_PMUV3_PERFCTR_ITLB_REFILL=09=09=09=09=3D 0x02,
+=09ARMV8_PMUV3_PERFCTR_DTLB_REFILL=09=09=09=09=3D 0x05,
+=09ARMV8_PMUV3_PERFCTR_MEM_ACCESS=09=09=09=09=3D 0x13,
+=09ARMV8_PMUV3_PERFCTR_L1_ICACHE_ACCESS=09=09=09=3D 0x14,
+=09ARMV8_PMUV3_PERFCTR_L1_DCACHE_WB=09=09=09=3D 0x15,
+=09ARMV8_PMUV3_PERFCTR_L2_CACHE_ACCESS=09=09=09=3D 0x16,
+=09ARMV8_PMUV3_PERFCTR_L2_CACHE_REFILL=09=09=09=3D 0x17,
+=09ARMV8_PMUV3_PERFCTR_L2_CACHE_WB=09=09=09=09=3D 0x18,
+=09ARMV8_PMUV3_PERFCTR_BUS_ACCESS=09=09=09=09=3D 0x19,
+=09ARMV8_PMUV3_PERFCTR_MEM_ERROR=09=09=09=09=3D 0x1A,
+=09ARMV8_PMUV3_PERFCTR_BUS_CYCLES=09=09=09=09=3D 0x1D,
+
+=09/*
+=09 * This isn't an architected event.
+=09 * We detect this event number and use the cycle counter instead.
+=09 */
+=09ARMV8_PMUV3_PERFCTR_CPU_CYCLES=09=09=09=09=3D 0xFF,
+};
+
+/* PMUv3 HW events mapping. */
+static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] =3D {
+=09[PERF_COUNT_HW_CPU_CYCLES]=09=09=3D ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
+=09[PERF_COUNT_HW_INSTRUCTIONS]=09=09=3D ARMV8_PMUV3_PERFCTR_INSTR_EXECUTE=
D,
+=09[PERF_COUNT_HW_CACHE_REFERENCES]=09=3D ARMV8_PMUV3_PERFCTR_L1_DCACHE_AC=
CESS,
+=09[PERF_COUNT_HW_CACHE_MISSES]=09=09=3D ARMV8_PMUV3_PERFCTR_L1_DCACHE_REF=
ILL,
+=09[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]=09=3D HW_OP_UNSUPPORTED,
+=09[PERF_COUNT_HW_BRANCH_MISSES]=09=09=3D ARMV8_PMUV3_PERFCTR_PC_BRANCH_MI=
S_PRED,
+=09[PERF_COUNT_HW_BUS_CYCLES]=09=09=3D HW_OP_UNSUPPORTED,
+=09[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]=09=3D HW_OP_UNSUPPORTED,
+=09[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]=09=3D HW_OP_UNSUPPORTED,
+};
+
+static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+=09=09=09=09=09=09[PERF_COUNT_HW_CACHE_OP_MAX]
+=09=09=09=09=09=09[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
+=09[C(L1D)] =3D {
+=09=09[C(OP_READ)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+=09=09=09[C(RESULT_MISS)]=09=3D ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+=09=09},
+=09=09[C(OP_WRITE)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
+=09=09=09[C(RESULT_MISS)]=09=3D ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
+=09=09},
+=09=09[C(OP_PREFETCH)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09},
+=09[C(L1I)] =3D {
+=09=09[C(OP_READ)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_WRITE)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_PREFETCH)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09},
+=09[C(LL)] =3D {
+=09=09[C(OP_READ)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_WRITE)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_PREFETCH)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09},
+=09[C(DTLB)] =3D {
+=09=09[C(OP_READ)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_WRITE)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_PREFETCH)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09},
+=09[C(ITLB)] =3D {
+=09=09[C(OP_READ)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_WRITE)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_PREFETCH)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09},
+=09[C(BPU)] =3D {
+=09=09[C(OP_READ)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+=09=09=09[C(RESULT_MISS)]=09=3D ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+=09=09},
+=09=09[C(OP_WRITE)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+=09=09=09[C(RESULT_MISS)]=09=3D ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+=09=09},
+=09=09[C(OP_PREFETCH)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09},
+=09[C(NODE)] =3D {
+=09=09[C(OP_READ)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_WRITE)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09=09[C(OP_PREFETCH)] =3D {
+=09=09=09[C(RESULT_ACCESS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09=09[C(RESULT_MISS)]=09=3D CACHE_OP_UNSUPPORTED,
+=09=09},
+=09},
+};
+
+/*
+ * Perf Events' indices
+ */
+#define=09ARMV8_IDX_CYCLE_COUNTER=090
+#define=09ARMV8_IDX_COUNTER0=091
+#define=09ARMV8_IDX_COUNTER_LAST=09(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num=
_events - 1)
+
+#define=09ARMV8_MAX_COUNTERS=0932
+#define=09ARMV8_COUNTER_MASK=09(ARMV8_MAX_COUNTERS - 1)
+
+/*
+ * ARMv8 low level PMU access
+ */
+
+/*
+ * Perf Event to low level counters mapping
+ */
+#define=09ARMV8_IDX_TO_COUNTER(x)=09\
+=09(((x) - ARMV8_IDX_COUNTER0) & ARMV8_COUNTER_MASK)
+
+/*
+ * Per-CPU PMCR: config reg
+ */
+#define ARMV8_PMCR_E=09=09(1 << 0) /* Enable all counters */
+#define ARMV8_PMCR_P=09=09(1 << 1) /* Reset all counters */
+#define ARMV8_PMCR_C=09=09(1 << 2) /* Cycle counter reset */
+#define ARMV8_PMCR_D=09=09(1 << 3) /* CCNT counts every 64th cpu cycle */
+#define ARMV8_PMCR_X=09=09(1 << 4) /* Export to ETM */
+#define ARMV8_PMCR_DP=09=09(1 << 5) /* Disable CCNT if non-invasive debug*=
/
+#define=09ARMV8_PMCR_N_SHIFT=0911=09 /* Number of counters supported */
+#define=09ARMV8_PMCR_N_MASK=090x1f
+#define=09ARMV8_PMCR_MASK=09=090x3f=09 /* Mask for writable bits */
+
+/*
+ * PMOVSR: counters overflow flag status reg
+ */
+#define=09ARMV8_OVSR_MASK=09=090xffffffff=09/* Mask for writable bits */
+#define=09ARMV8_OVERFLOWED_MASK=09ARMV8_OVSR_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define=09ARMV8_EVTYPE_MASK=090xc00000ff=09/* Mask for writable bits */
+#define=09ARMV8_EVTYPE_EVENT=090xff=09=09/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv3
+ */
+#define=09ARMV8_EXCLUDE_EL1=09(1 << 31)
+#define=09ARMV8_EXCLUDE_EL0=09(1 << 30)
+#define=09ARMV8_INCLUDE_EL2=09(1 << 27)
+
+static inline u32 armv8pmu_pmcr_read(void)
+{
+=09u32 val;
+=09asm volatile("mrs %0, pmcr_el0" : "=3Dr" (val));
+=09return val;
+}
+
+static inline void armv8pmu_pmcr_write(u32 val)
+{
+=09val &=3D ARMV8_PMCR_MASK;
+=09isb();
+=09asm volatile("msr pmcr_el0, %0" :: "r" (val));
+}
+
+static inline int armv8pmu_has_overflowed(u32 pmovsr)
+{
+=09return pmovsr & ARMV8_OVERFLOWED_MASK;
+}
+
+static inline int armv8pmu_counter_valid(int idx)
+{
+=09return idx >=3D ARMV8_IDX_CYCLE_COUNTER && idx <=3D ARMV8_IDX_COUNTER_L=
AST;
+}
+
+static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
+{
+=09int ret =3D 0;
+=09u32 counter;
+
+=09if (!armv8pmu_counter_valid(idx)) {
+=09=09pr_err("CPU%u checking wrong counter %d overflow status\n",
+=09=09=09smp_processor_id(), idx);
+=09} else {
+=09=09counter =3D ARMV8_IDX_TO_COUNTER(idx);
+=09=09ret =3D pmnc & BIT(counter);
+=09}
+
+=09return ret;
+}
+
+static inline int armv8pmu_select_counter(int idx)
+{
+=09u32 counter;
+
+=09if (!armv8pmu_counter_valid(idx)) {
+=09=09pr_err("CPU%u selecting wrong PMNC counter %d\n",
+=09=09=09smp_processor_id(), idx);
+=09=09return -EINVAL;
+=09}
+
+=09counter =3D ARMV8_IDX_TO_COUNTER(idx);
+=09asm volatile("msr pmselr_el0, %0" :: "r" (counter));
+=09isb();
+
+=09return idx;
+}
+
+static inline u32 armv8pmu_read_counter(int idx)
+{
+=09u32 value =3D 0;
+
+=09if (!armv8pmu_counter_valid(idx))
+=09=09pr_err("CPU%u reading wrong counter %d\n",
+=09=09=09smp_processor_id(), idx);
+=09else if (idx =3D=3D ARMV8_IDX_CYCLE_COUNTER)
+=09=09asm volatile("mrs %0, pmccntr_el0" : "=3Dr" (value));
+=09else if (armv8pmu_select_counter(idx) =3D=3D idx)
+=09=09asm volatile("mrs %0, pmxevcntr_el0" : "=3Dr" (value));
+
+=09return value;
+}
+
+static inline void armv8pmu_write_counter(int idx, u32 value)
+{
+=09if (!armv8pmu_counter_valid(idx))
+=09=09pr_err("CPU%u writing wrong counter %d\n",
+=09=09=09smp_processor_id(), idx);
+=09else if (idx =3D=3D ARMV8_IDX_CYCLE_COUNTER)
+=09=09asm volatile("msr pmccntr_el0, %0" :: "r" (value));
+=09else if (armv8pmu_select_counter(idx) =3D=3D idx)
+=09=09asm volatile("msr pmxevcntr_el0, %0" :: "r" (value));
+}
+
+static inline void armv8pmu_write_evtype(int idx, u32 val)
+{
+=09if (armv8pmu_select_counter(idx) =3D=3D idx) {
+=09=09val &=3D ARMV8_EVTYPE_MASK;
+=09=09asm volatile("msr pmxevtyper_el0, %0" :: "r" (val));
+=09}
+}
+
+static inline int armv8pmu_enable_counter(int idx)
+{
+=09u32 counter;
+
+=09if (!armv8pmu_counter_valid(idx)) {
+=09=09pr_err("CPU%u enabling wrong PMNC counter %d\n",
+=09=09=09smp_processor_id(), idx);
+=09=09return -EINVAL;
+=09}
+
+=09counter =3D ARMV8_IDX_TO_COUNTER(idx);
+=09asm volatile("msr pmcntenset_el0, %0" :: "r" (BIT(counter)));
+=09return idx;
+}
+
+static inline int armv8pmu_disable_counter(int idx)
+{
+=09u32 counter;
+
+=09if (!armv8pmu_counter_valid(idx)) {
+=09=09pr_err("CPU%u disabling wrong PMNC counter %d\n",
+=09=09=09smp_processor_id(), idx);
+=09=09return -EINVAL;
+=09}
+
+=09counter =3D ARMV8_IDX_TO_COUNTER(idx);
+=09asm volatile("msr pmcntenclr_el0, %0" :: "r" (BIT(counter)));
+=09return idx;
+}
+
+static inline int armv8pmu_enable_intens(int idx)
+{
+=09u32 counter;
+
+=09if (!armv8pmu_counter_valid(idx)) {
+=09=09pr_err("CPU%u enabling wrong PMNC counter IRQ enable %d\n",
+=09=09=09smp_processor_id(), idx);
+=09=09return -EINVAL;
+=09}
+
+=09counter =3D ARMV8_IDX_TO_COUNTER(idx);
+=09asm volatile("msr pmintenset_el1, %0" :: "r" (BIT(counter)));
+=09return idx;
+}
+
+static inline int armv8pmu_disable_intens(int idx)
+{
+=09u32 counter;
+
+=09if (!armv8pmu_counter_valid(idx)) {
+=09=09pr_err("CPU%u disabling wrong PMNC counter IRQ enable %d\n",
+=09=09=09smp_processor_id(), idx);
+=09=09return -EINVAL;
+=09}
+
+=09counter =3D ARMV8_IDX_TO_COUNTER(idx);
+=09asm volatile("msr pmintenclr_el1, %0" :: "r" (BIT(counter)));
+=09isb();
+=09/* Clear the overflow flag in case an interrupt is pending. */
+=09asm volatile("msr pmovsclr_el0, %0" :: "r" (BIT(counter)));
+=09isb();
+=09return idx;
+}
+
+static inline u32 armv8pmu_getreset_flags(void)
+{
+=09u32 value;
+
+=09/* Read */
+=09asm volatile("mrs %0, pmovsclr_el0" : "=3Dr" (value));
+
+=09/* Write to clear flags */
+=09value &=3D ARMV8_OVSR_MASK;
+=09asm volatile("msr pmovsclr_el0, %0" :: "r" (value));
+
+=09return value;
+}
+
+static void armv8pmu_enable_event(struct hw_perf_event *hwc, int idx)
+{
+=09unsigned long flags;
+=09struct pmu_hw_events *events =3D cpu_pmu->get_hw_events();
+
+=09/*
+=09 * Enable counter and interrupt, and set the counter to count
+=09 * the event that we're interested in.
+=09 */
+=09raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+=09/*
+=09 * Disable counter
+=09 */
+=09armv8pmu_disable_counter(idx);
+
+=09/*
+=09 * Set event (if destined for PMNx counters).
+=09 */
+=09armv8pmu_write_evtype(idx, hwc->config_base);
+
+=09/*
+=09 * Enable interrupt for this counter
+=09 */
+=09armv8pmu_enable_intens(idx);
+
+=09/*
+=09 * Enable counter
+=09 */
+=09armv8pmu_enable_counter(idx);
+
+=09raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void armv8pmu_disable_event(struct hw_perf_event *hwc, int idx)
+{
+=09unsigned long flags;
+=09struct pmu_hw_events *events =3D cpu_pmu->get_hw_events();
+
+=09/*
+=09 * Disable counter and interrupt
+=09 */
+=09raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+=09/*
+=09 * Disable counter
+=09 */
+=09armv8pmu_disable_counter(idx);
+
+=09/*
+=09 * Disable interrupt for this counter
+=09 */
+=09armv8pmu_disable_intens(idx);
+
+=09raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
+{
+=09u32 pmovsr;
+=09struct perf_sample_data data;
+=09struct pmu_hw_events *cpuc;
+=09struct pt_regs *regs;
+=09int idx;
+
+=09/*
+=09 * Get and reset the IRQ flags
+=09 */
+=09pmovsr =3D armv8pmu_getreset_flags();
+
+=09/*
+=09 * Did an overflow occur?
+=09 */
+=09if (!armv8pmu_has_overflowed(pmovsr))
+=09=09return IRQ_NONE;
+
+=09/*
+=09 * Handle the counter(s) overflow(s)
+=09 */
+=09regs =3D get_irq_regs();
+
+=09cpuc =3D &__get_cpu_var(cpu_hw_events);
+=09for (idx =3D 0; idx < cpu_pmu->num_events; ++idx) {
+=09=09struct perf_event *event =3D cpuc->events[idx];
+=09=09struct hw_perf_event *hwc;
+
+=09=09/* Ignore if we don't have an event. */
+=09=09if (!event)
+=09=09=09continue;
+
+=09=09/*
+=09=09 * We have a single interrupt for all counters. Check that
+=09=09 * each counter has overflowed before we process it.
+=09=09 */
+=09=09if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
+=09=09=09continue;
+
+=09=09hwc =3D &event->hw;
+=09=09armpmu_event_update(event, hwc, idx);
+=09=09perf_sample_data_init(&data, 0, hwc->last_period);
+=09=09if (!armpmu_event_set_period(event, hwc, idx))
+=09=09=09continue;
+
+=09=09if (perf_event_overflow(event, &data, regs))
+=09=09=09cpu_pmu->disable(hwc, idx);
+=09}
+
+=09/*
+=09 * Handle the pending perf events.
+=09 *
+=09 * Note: this call *must* be run with interrupts disabled. For
+=09 * platforms that can have the PMU interrupts raised as an NMI, this
+=09 * will not work.
+=09 */
+=09irq_work_run();
+
+=09return IRQ_HANDLED;
+}
+
+static void armv8pmu_start(void)
+{
+=09unsigned long flags;
+=09struct pmu_hw_events *events =3D cpu_pmu->get_hw_events();
+
+=09raw_spin_lock_irqsave(&events->pmu_lock, flags);
+=09/* Enable all counters */
+=09armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMCR_E);
+=09raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void armv8pmu_stop(void)
+{
+=09unsigned long flags;
+=09struct pmu_hw_events *events =3D cpu_pmu->get_hw_events();
+
+=09raw_spin_lock_irqsave(&events->pmu_lock, flags);
+=09/* Disable all counters */
+=09armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMCR_E);
+=09raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
+=09=09=09=09  struct hw_perf_event *event)
+{
+=09int idx;
+=09unsigned long evtype =3D event->config_base & ARMV8_EVTYPE_EVENT;
+
+=09/* Always place a cycle counter into the cycle counter. */
+=09if (evtype =3D=3D ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
+=09=09if (test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
+=09=09=09return -EAGAIN;
+
+=09=09return ARMV8_IDX_CYCLE_COUNTER;
+=09}
+
+=09/*
+=09 * For anything other than a cycle counter, try and use
+=09 * the events counters
+=09 */
+=09for (idx =3D ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
+=09=09if (!test_and_set_bit(idx, cpuc->used_mask))
+=09=09=09return idx;
+=09}
+
+=09/* The counters are all in use. */
+=09return -EAGAIN;
+}
+
+/*
+ * Add an event filter to a given event. This will only work for PMUv2 PMU=
s.
+ */
+static int armv8pmu_set_event_filter(struct hw_perf_event *event,
+=09=09=09=09     struct perf_event_attr *attr)
+{
+=09unsigned long config_base =3D 0;
+
+=09if (attr->exclude_idle)
+=09=09return -EPERM;
+=09if (attr->exclude_user)
+=09=09config_base |=3D ARMV8_EXCLUDE_EL0;
+=09if (attr->exclude_kernel)
+=09=09config_base |=3D ARMV8_EXCLUDE_EL1;
+=09if (!attr->exclude_hv)
+=09=09config_base |=3D ARMV8_INCLUDE_EL2;
+
+=09/*
+=09 * Install the filter into config_base as this is used to
+=09 * construct the event type.
+=09 */
+=09event->config_base =3D config_base;
+
+=09return 0;
+}
+
+static void armv8pmu_reset(void *info)
+{
+=09u32 idx, nb_cnt =3D cpu_pmu->num_events;
+
+=09/* The counter and interrupt enable registers are unknown at reset. */
+=09for (idx =3D ARMV8_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx)
+=09=09armv8pmu_disable_event(NULL, idx);
+
+=09/* Initialize & Reset PMNC: C and P bits. */
+=09armv8pmu_pmcr_write(ARMV8_PMCR_P | ARMV8_PMCR_C);
+
+=09/* Disable access from userspace. */
+=09asm volatile("msr pmuserenr_el0, %0" :: "r" (0));
+}
+
+static int armv8_pmuv3_map_event(struct perf_event *event)
+{
+=09return map_cpu_event(event, &armv8_pmuv3_perf_map,
+=09=09=09=09&armv8_pmuv3_perf_cache_map, 0xFF);
+}
+
+static struct arm_pmu armv8pmu =3D {
+=09.handle_irq=09=09=3D armv8pmu_handle_irq,
+=09.enable=09=09=09=3D armv8pmu_enable_event,
+=09.disable=09=09=3D armv8pmu_disable_event,
+=09.read_counter=09=09=3D armv8pmu_read_counter,
+=09.write_counter=09=09=3D armv8pmu_write_counter,
+=09.get_event_idx=09=09=3D armv8pmu_get_event_idx,
+=09.start=09=09=09=3D armv8pmu_start,
+=09.stop=09=09=09=3D armv8pmu_stop,
+=09.reset=09=09=09=3D armv8pmu_reset,
+=09.max_period=09=09=3D (1LLU << 32) - 1,
+};
+
+static u32 __init armv8pmu_read_num_pmnc_events(void)
+{
+=09u32 nb_cnt;
+
+=09/* Read the nb of CNTx counters supported from PMNC */
+=09nb_cnt =3D (armv8pmu_pmcr_read() >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_=
MASK;
+
+=09/* Add the CPU cycles counter and return */
+=09return nb_cnt + 1;
+}
+
+static struct arm_pmu *__init armv8_pmuv3_pmu_init(void)
+{
+=09armv8pmu.name=09=09=09=3D "arm/armv8-pmuv3";
+=09armv8pmu.map_event=09=09=3D armv8_pmuv3_map_event;
+=09armv8pmu.num_events=09=09=3D armv8pmu_read_num_pmnc_events();
+=09armv8pmu.set_event_filter=09=3D armv8pmu_set_event_filter;
+=09return &armv8pmu;
+}
+
+/*
+ * Ensure the PMU has sane values out of reset.
+ * This requires SMP to be available, so exists as a separate initcall.
+ */
+static int __init
+cpu_pmu_reset(void)
+{
+=09if (cpu_pmu && cpu_pmu->reset)
+=09=09return on_each_cpu(cpu_pmu->reset, NULL, 1);
+=09return 0;
+}
+arch_initcall(cpu_pmu_reset);
+
+/*
+ * PMU platform driver and devicetree bindings.
+ */
+static struct of_device_id armpmu_of_device_ids[] =3D {
+=09{.compatible =3D "arm,armv8-pmuv3"},
+=09{},
+};
+
+static int __devinit armpmu_device_probe(struct platform_device *pdev)
+{
+=09if (!cpu_pmu)
+=09=09return -ENODEV;
+
+=09cpu_pmu->plat_device =3D pdev;
+=09return 0;
+}
+
+static struct platform_driver armpmu_driver =3D {
+=09.driver=09=09=3D {
+=09=09.name=09=3D "arm-pmu",
+=09=09.of_match_table =3D armpmu_of_device_ids,
+=09},
+=09.probe=09=09=3D armpmu_device_probe,
+};
+
+static int __init register_pmu_driver(void)
+{
+=09return platform_driver_register(&armpmu_driver);
+}
+device_initcall(register_pmu_driver);
+
+static struct pmu_hw_events *armpmu_get_cpu_events(void)
+{
+=09return &__get_cpu_var(cpu_hw_events);
+}
+
+static void __init cpu_pmu_init(struct arm_pmu *armpmu)
+{
+=09int cpu;
+=09for_each_possible_cpu(cpu) {
+=09=09struct pmu_hw_events *events =3D &per_cpu(cpu_hw_events, cpu);
+=09=09events->events =3D per_cpu(hw_events, cpu);
+=09=09events->used_mask =3D per_cpu(used_mask, cpu);
+=09=09raw_spin_lock_init(&events->pmu_lock);
+=09}
+=09armpmu->get_hw_events =3D armpmu_get_cpu_events;
+}
+
+static int __init init_hw_perf_events(void)
+{
+=09u64 dfr =3D read_cpuid(ID_AA64DFR0_EL1);
+
+=09switch ((dfr >> 8) & 0xf) {
+=09case 0x1:=09/* PMUv3 */
+=09=09cpu_pmu =3D armv8_pmuv3_pmu_init();
+=09=09break;
+=09}
+
+=09if (cpu_pmu) {
+=09=09pr_info("enabled with %s PMU driver, %d counters available\n",
+=09=09=09cpu_pmu->name, cpu_pmu->num_events);
+=09=09cpu_pmu_init(cpu_pmu);
+=09=09armpmu_register(cpu_pmu, "cpu", PERF_TYPE_RAW);
+=09} else {
+=09=09pr_info("no hardware support available\n");
+=09}
+
+=09return 0;
+}
+early_initcall(init_hw_perf_events);
+
+/*
+ * Callchain handling code.
+ */
+struct frame_tail {
+=09struct frame_tail   __user *fp;
+=09unsigned long=09    lr;
+} __attribute__((packed));
+
+/*
+ * Get the return address for a single stackframe and return a pointer to =
the
+ * next frame tail.
+ */
+static struct frame_tail __user *
+user_backtrace(struct frame_tail __user *tail,
+=09       struct perf_callchain_entry *entry)
+{
+=09struct frame_tail buftail;
+=09unsigned long err;
+
+=09/* Also check accessibility of one struct frame_tail beyond */
+=09if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
+=09=09return NULL;
+
+=09pagefault_disable();
+=09err =3D __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
+=09pagefault_enable();
+
+=09if (err)
+=09=09return NULL;
+
+=09perf_callchain_store(entry, buftail.lr);
+
+=09/*
+=09 * Frame pointers should strictly progress back up the stack
+=09 * (towards higher addresses).
+=09 */
+=09if (tail >=3D buftail.fp)
+=09=09return NULL;
+
+=09return buftail.fp;
+}
+
+void perf_callchain_user(struct perf_callchain_entry *entry,
+=09=09=09 struct pt_regs *regs)
+{
+=09struct frame_tail __user *tail;
+
+=09tail =3D (struct frame_tail __user *)regs->regs[29];
+
+=09while (entry->nr < PERF_MAX_STACK_DEPTH &&
+=09       tail && !((unsigned long)tail & 0xf))
+=09=09tail =3D user_backtrace(tail, entry);
+}
+
+/*
+ * Gets called by walk_stackframe() for every stackframe. This will be cal=
led
+ * whist unwinding the stackframe and is like a subroutine return so we us=
e
+ * the PC.
+ */
+static int callchain_trace(struct stackframe *frame, void *data)
+{
+=09struct perf_callchain_entry *entry =3D data;
+=09perf_callchain_store(entry, frame->pc);
+=09return 0;
+}
+
+void perf_callchain_kernel(struct perf_callchain_entry *entry,
+=09=09=09   struct pt_regs *regs)
+{
+=09struct stackframe frame;
+
+=09frame.fp =3D regs->regs[29];
+=09frame.sp =3D regs->sp;
+=09frame.pc =3D regs->pc;
+=09walk_stackframe(&frame, callchain_trace, entry);
+}
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index f960ccb..8c36763 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -88,6 +88,12 @@ void get_term_dimensions(struct winsize *ws);
 #define CPUINFO_PROC=09"Processor"
 #endif
=20
+#ifdef __aarch64__
+#include "../../arch/arm64/include/asm/unistd.h"
+#define rmb()=09=09asm volatile("dmb ld" ::: "memory")
+#define cpu_relax()=09asm volatile("yield" ::: "memory")
+#endif
+
 #ifdef __mips__
 #include "../../arch/mips/include/asm/unistd.h"
 #define rmb()=09=09asm volatile(=09=09=09=09=09\

