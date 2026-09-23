Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901959B670
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202971; cv=none; b=C6hpCLUI04Hb8FcHdtYXLdDtfJAVnPmM5K0Bfb+ryf2fkyvVpDI1BRD81TCdmPz8hw0vCLLUEftJTh2fzbMMYb9mvyvfnKTVdaaQiuAda0fostE8247Lz5nxXxYg74UEyiHVKYMnKpjedX2Arhak0ajPtorJEuNd5okGC64VcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202971; c=relaxed/simple;
	bh=QtLlj6Iu73k3grCcOM/3Dv8iV4bzRLVfs0OzTMwLUD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFmAa9fI2xtMSBbAv7krf0AF8Zxm1m0P9OrAPPbOB1CN/O9QMRGjLXdUZDFHnq2zl8HoDqkJ+GrZSkoK7V+lD46dQEnIqvqnqmEpdDLdcylrj4OefOeD5ZNVvDwBtnEoJ3XIl1snIPklOcWu4aaKPK/WJtwqfjZlJLRdi6LIt+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfLSPEbI; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfLSPEbI"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7f4f0d37f93so1122404a34.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202964; x=1790807764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wjoK6UPJsIB1SeRUgRXYevzBybItepThbTMT5icwGrE=;
        b=jfLSPEbIPJd+5+vWl06rNKwdQgwf6b3oJRKlqVrvOrKrRr6ONSrXvB3W9lbG/YRR6L
         wbDoZwG13zMyjFv3RYpW4tQJUI/s0z/4vuhbkYsmFPBNuZ1Q04J9UIk+/nQDTkjYX6Oy
         KBQJUSCacG6hf2Q9DIEDgyrpTqCvUbzBtgdBSSzrV334oFzCU+Y8EAH/DlT2OiO9gp9I
         iwdnUFUHebzW1RixOyrSwH8jPUgSpVFZ3C0y/WClq4DvamWkCQF6V29LovzQPc4X4O9Q
         0SIrT6ud5U8Qr1vRlyshu0NtmLCygWUhNF1YrHVoeySRoGqMI33iaHN0oKk4jkLhYvG0
         hyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202964; x=1790807764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wjoK6UPJsIB1SeRUgRXYevzBybItepThbTMT5icwGrE=;
        b=UfQGM7rH1Sip5GDWK0+2KDPloZj3BmdsQB5LCO7u/0dl8pOFc6qFIXv81u/H/TimCZ
         sGBidcgu8CBDPdZh/SflQeO5PGmuaW4azXdC45ViCDWiY9IAgljmlPeK9pp2P0kKE56J
         2VaRwCmhNwK7exMjoSHeF5RJxdz2n9K65treVq7hw8u0Ix5uMhjvj+9uWpIrPEnYwW2C
         MaitaFQ71qfY0sS8+yRDbA8dsd+8GOmtNNEnh13OMv/qj/EcgfpR+6FRaDykYzprx1qW
         W6tDrgB2B+WrnmX0c/H28Q0arltVxmlbyGo94CeAwAx9Ouq4F9HE43LzFg908nwgIiXD
         pr4A==
X-Forwarded-Encrypted: i=1; AKwUvBwyyxrW7x2n1JEIjG7uRRuUaDLPyEOMLwbqyIvYwsbWtYNKVDXwXxlIV0vCEEj6MU8dyYAWS/smHnYd@vger.kernel.org
X-Gm-Message-State: AFuF++non+dx65gWeuNZI5NxnPFPNB+vXWcJNxFpvwgv9TQ5r+211nRd
	k+PFq+QpY8SCL9UMPEHH7Fp9wUFWdjnaWLWeahSq0jLB0h020xeRFBq9
X-Gm-Gg: AYBFou3lyikulcXsCwYkFvsj9SatMKqHitaWt/TQO8x25gcaI3gHorCUPCB2yAB+XWF
	Yu11xfG3mS1cgRE91QGuZRtXqnowqB2/MByhrZl+noojd3pL5vVngrcWZdgR489x0f/NRNeSota
	MXNuLdlxuR7Cl4umPsGVDyoZ+vvI4uEYgDtMvMACeZLQOrnWPcBJ+6hSCH0xWDsuj7R09YKlJd1
	hUj+Yw1LW3QbNpnGmEMC5R6quThB/Q80KNZ9knPvZ1kK2DXWlorvQ1eNlCVQVySIyBmd+sbFUYl
	sDT6aQKOSFSqLoeI6JeOO5+xDexBUZmdrHQExZykbNEET9q4dF26Dki3Gnn+QrT/S9UG+7z7AVB
	6bvCsy2+3IgLK/qU+LekH6WJIl3q7r2at9r5XL2ZkqPxlambp2w0tQzgHFVP/05TVa6kKC+NRka
	KM8d4fP3V8AMV0fh/g6l5jPZxULahkVnv6g/2BXksNCMth0luKuLPhef4z6b5SsyIP7UDyX5+MA
	Wo6XoKEG5gb/MmvF7aAogwdxMzR6zLDtzH/ne97rG4VcRzc1KOjXi9+Ftb+meLkAV4sBQjptxdj
	OEM4F7ouf4ZFqXdx2FI=
X-Received: by 2002:a05:6808:4f60:b0:4c3:9892:96e1 with SMTP id 5614622812f47-4d72ca31a99mr690791b6e.25.1790202964066;
        Wed, 23 Sep 2026 15:36:04 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:35:01 -0600
Subject: [PATCH v11 37/38] dyndbg: add +c flag to count pr_debug calls
 without printing
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-37-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=16742;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=QtLlj6Iu73k3grCcOM/3Dv8iV4bzRLVfs0OzTMwLUD0=;
 b=V3VU8JWxGCvVBlUx1DykuPpp4lIj265cWS/0Ru59SuI3cqoVRwnQm3ABIBSlgg7/3TLCJSWUN
 qp99t02dwAzA3z037HAZE6gejRMXQTtSCJq3BZ72TLjp2XBKIBCceBR
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Introduce a +c flag, to increment a per-cpu counter: ddebug_count
when a flagged pr_debug() is called.

Reset the counter with:
  echo reset_stats > /proc/dynamic_debug/control

and see the count value with:
  tail -n1 /proc/dynamic_debug/control
  #: total count: 2295401

This counter lets us count callrates of arbitrary sets of "enabled"
pr_debugs, over user defined intervals, without actually doing the
printk work.  Each increment represents a fetch from main memory and a
bit test, which are now elided because the pr_debug is backed by a
static-key.

CONFIG_DRM_USE_DYNAMIC_DEBUG=y gives drm a per callsite static-key to
avoid the cache-line insult of actually reading __drm_debug.  On my
amdgpu + nvidia laptop, thats ~3200 callsites.

The benchmarks below are from a recent build running on my asus
amdgpu + nouveau laptop, using scripts from below the snip.

  #> count_hits 30 hammer_vk --
  Banging on: hammer_vk (&)
  [1] 100847
  [1]+  Done                       hammer_vk
  #: total hits: 2295401

  #> count_hits 30 hammer_vk -- DRM_UT_CORE
  Banging on: hammer_vk (&)
  [1] 99910
  [1]+  Done                       hammer_vk
  #: total hits: 2204406

Notably, the DRM_UT_CORE category dominates the call traffic, not
DRM_UT_VBL or any others, which contribute little extra to the above.

To see the distribution of debug categories (for vkcube load)

  #> isolate_drm_hits 2> /dev/null
  Starting isolation study: 10s per class using vkcube
  ----------------------------------------------------------
  DRM CLASS            | TOTAL HITS
  ----------------------------------------------------------
  DRM_UT_CORE          | 85305
  DRM_UT_DRIVER        | 0
  DRM_UT_KMS           | 1435
  DRM_UT_PRIME         | 0
  DRM_UT_ATOMIC        | 13645
  DRM_UT_VBL           | 4071
  DRM_UT_STATE         | 1780
  DRM_UT_LEASE         | 0
  DRM_UT_DP            | 0
  DRM_UT_DRMRES        | 0
  FOO                  | 0

REVIEW:

In every minute, 12 vkcubes issue ~4.6M drm_debug_enabled(__drm_debug)
macro-calls.  To test the bits, they all *may* go out to main memory,
though __drm_debug is ro-mostly.  Still, theres significant cache-line
eviction, and potentially meaningful costs we can avoid.

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, each pr_debug call-site is
replaced by a static-key, with the off-cost of few NOOPs, avoiding all
the cache-line thrashing.

NOTES:

The +c flag invokes the callsite, but avoids the heavy syslog writing.
It is currently independent of +p, but it could be compressed into a
state-machine, and the bit recovered, but not til we need to do so.

The +c flag has no predictive quality; to count usr_dbg() callsites,
you must have reimplemnted them already with pr_debug.  This just
gives DRM folks some numbers to consider, to balance against the work
needed to test this series.

Assisted-by: Gemini-CLI:gemini-2.5-pro
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v11:
. only print counted_calls in control epilogue when count > 0.

v10:
. add __DYNAMIC_DEBUG_BRANCH() checking _ENABLED while DYNAMIC_DEBUG_BRANCH() checks _ACTIVE.
. add early return guards in __dynamic_*_dbg() helpers checking _ACTIVE.

. add __DYNAMIC_DEBUG_BRANCH() checking _ENABLED while DYNAMIC_DEBUG_BRANCH() checks _ACTIVE.
. add early return guards in __dynamic_*_dbg() helpers checking _ACTIVE.

v9:
. add missing kfree(tmpbuf) in reset_stats handler before early return.
. sum across for_each_possible_cpu() in get_ddebug_call_count() for hotplug stability.
. update !CONFIG_JUMP_LABEL branch check to check _DPRINTK_FLAGS_ENABLED.

function ddcmd () {
    local cmd="$*"
    # Direct write - assume the parent script is run with 'sudo' or as root
    [ -f /proc/dynamic_debug/control ] || return 1;
    if ! echo "$cmd" > /proc/dynamic_debug/control 2>/tmp/dd_err; then
        local ret=$?
        echo "ERROR ($ret): $(cat /tmp/dd_err)" #>&2
        # Check dmesg for the "!" syntax error on wk-baseline
        dmesg | grep -i "dyndbg" | tail -n 2 #>&2
        return $ret
    fi
}

function _get_cal_count() {
    if [ ! -f /proc/interrupts ]; then
        echo 0
        return
    fi
    # sum all CPU columns for any line starting with CAL:
    # the awk starts at $2 to skip the label (CAL:)
    # NF-2 skips the trailing text "Function call interrupts"
    grep "^ *CAL:" /proc/interrupts | \
        awk '{ for(i=2; i<=NF-2; i++) sum+=$i } END { print sum+0 }'
}

function wrap_cal_count() {
    local cal_before
    cal_before=$(_get_cal_count)
    printf " wrapping: %s\n" "$*" #>&2
    #time \
	"$@" || return 1
    local cal_after
    cal_after=$(_get_cal_count)
    local delta=$(( ${cal_after:-0} - ${cal_before:-0} ))
    printf "Delta-CAL (IPI): %d\n" "$delta" #>&2
}

TEST_CLASSES_LIST="D2_CORE D2_DRIVER D2_KMS D2_PRIME D2_ATOMIC D2_VBL D2_STATE D2_LEASE D2_DP D2_DRMRES V0 V1 V2 V3 V4 V5 V6 V7"

DRM_CLASSES_LIST="DRM_UT_CORE DRM_UT_DRIVER DRM_UT_KMS DRM_UT_PRIME DRM_UT_ATOMIC DRM_UT_VBL DRM_UT_STATE DRM_UT_LEASE DRM_UT_DP DRM_UT_DRMRES"

function dd_setup_() {
    local flags="${1:-+p}"
    # Use $2 if provided, otherwise fallback to the full list
    local CLASSES_LIST="$2"
    local q=""
    local C

    # Safeguard: if list is empty, don't do anything
    [[ -z "$CLASSES_LIST" ]] && echo "no classes!" && return 0

    for C in $CLASSES_LIST; do
        q+="class $C $flags ; "
    done
    #echo "sending: $q"
    ddcmd "$q"
}

function dd_setup_test() {
    modprobe test_dynamic_debug || return 1
    dd_setup_ $1 "${2:-$TEST_CLASSES_LIST}"
}

function dd_setup_drm() {
    dd_setup_ $1 "${2:-$DRM_CLASSES_LIST}"
}

function count_hits() {
    local duration=60
    [[ "$1" =~ ^[0-9]+$ ]] && { duration=$1; shift; }

    local cmd_to_run=()
    local custom_classes=""
    while [[ $# -gt 0 ]]; do
        if [[ "$1" == "--" ]]; then
            shift
            custom_classes="$*"
            break
        fi
        cmd_to_run+=("$1")
        shift
    done

    ddcmd reset_stats
    dd_setup_drm "+c" "$custom_classes"

    if [[ ${#cmd_to_run[@]} -gt 0 ]]; then
        echo "Banging on: ${cmd_to_run[*]} (&)"
        # Use eval so bash functions work
        eval "${cmd_to_run[*]} &"
        local cmd_pid=$!
        sleep "$duration"
        killall vkcube 2>/dev/null
        kill "$cmd_pid" 2>/dev/null
    else
        sleep "$duration"
    fi

    dd_setup_drm "-c" "$custom_classes"
    tail -n1 /proc/dynamic_debug/control
}

function hammer_vk() {
    for i in {1..12}; do vkcube >/dev/null 2>&1 & done
}

function isolate_drm_hits() {
    local duration=${1:-10}
    local cmd=${2:-vkcube}

    echo "Starting isolation study: ${duration}s per class using ${cmd}"
    echo "----------------------------------------------------------"
    printf "%-20s | %-10s\n" "DRM CLASS" "TOTAL HITS"
    echo "----------------------------------------------------------"

    for class in $DRM_CLASSES_LIST FOO; do
        # Run count_hits for the specific class
        # Use 'capture' logic to grab only the hit count from the tail output
        result=$(count_hits "$duration" "$cmd" -- "$class" | grep "total hits" | awk '{print $NF}')

        printf "%-20s | %-10s\n" "$class" "$result"
    done
    #result=$(count_hits "$duration" "$cmd" -- "FOO" | grep "total hits" | awk '{print $NF}')
    #printf "%-20s | %-10s\n" "$class" "$result"
}

[ $SHLVL == 2 -a -n "$*" ] && echo " doing: $* in $PWD" #>&2

if [ $SHLVL == 2 ]; then
    # run args as cmd
    $@
fi
---
 include/linux/dynamic_debug.h                      | 40 ++++++++++++++-----
 lib/dynamic_debug.c                                | 45 ++++++++++++++++++++--
 .../selftests/dynamic_debug/dyndbg_selftest.sh     |  7 ++--
 3 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index f411a7636cf1..04620b869832 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -49,6 +49,9 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
 #define _DPRINTK_FLAGS_INCL_STACK	(1<<6)
+#define _DPRINTK_FLAGS_COUNT		(1<<7)
+
+#define _DPRINTK_FLAGS_BRANCH (_DPRINTK_FLAGS_PRINT | _DPRINTK_FLAGS_COUNT)
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
@@ -383,13 +386,13 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define _DPRINTK_KEY_INIT .key.dd_key_true = (STATIC_KEY_TRUE_INIT)
 
-#define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	static_branch_likely(&descriptor.key.dd_key_true)
+#define __DYNAMIC_DEBUG_BRANCH(descriptor) \
+	static_branch_likely(&(descriptor).key.dd_key_true)
 #else
 #define _DPRINTK_KEY_INIT .key.dd_key_false = (STATIC_KEY_FALSE_INIT)
 
-#define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	static_branch_unlikely(&descriptor.key.dd_key_false)
+#define __DYNAMIC_DEBUG_BRANCH(descriptor) \
+	static_branch_unlikely(&(descriptor).key.dd_key_false)
 #endif
 
 #else /* !CONFIG_JUMP_LABEL */
@@ -397,15 +400,30 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define _DPRINTK_KEY_INIT
 
 #ifdef DEBUG
-#define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+#define __DYNAMIC_DEBUG_BRANCH(descriptor) \
+	likely((descriptor).flags & _DPRINTK_FLAGS_BRANCH)
 #else
-#define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+#define __DYNAMIC_DEBUG_BRANCH(descriptor) \
+	unlikely((descriptor).flags & _DPRINTK_FLAGS_BRANCH)
 #endif
 
 #endif /* CONFIG_JUMP_LABEL */
 
+void ddebug_increment_call_count(void);
+#define DYNAMIC_DEBUG_COUNT(descriptor) do {			\
+	if (unlikely((descriptor).flags & _DPRINTK_FLAGS_COUNT)) \
+		ddebug_increment_call_count();			\
+} while (0)
+
+#define DYNAMIC_DEBUG_BRANCH(descriptor) ({				\
+	bool __dd_print = false;					\
+	if (__DYNAMIC_DEBUG_BRANCH(descriptor)) {			\
+		DYNAMIC_DEBUG_COUNT(descriptor);			\
+		__dd_print = !!((descriptor).flags & _DPRINTK_FLAGS_PRINT); \
+	}								\
+	__dd_print;							\
+})
+
 /*
  * Factory macros: ($prefix)dynamic_func_call($suffix)
  *
@@ -417,6 +435,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
+
 #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
@@ -431,8 +450,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {					\
-		func(__VA_ARGS__);					\
-		__dynamic_dump_stack(id);				\
+		func(__VA_ARGS__);				\
+		__dynamic_dump_stack(id);			\
 	}								\
 } while (0)
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
@@ -519,6 +538,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)	\
 	module_param_named(_name, _bits, uint, 0600)
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
+#define __DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DECLARE_DYNDBG_CLASSMAP(...)
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 88440c1f6abb..9b789287afe5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -19,12 +19,14 @@
 #include <linux/kallsyms.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/percpu.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/list.h>
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+
 #include <linux/parser.h>
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
@@ -71,6 +73,21 @@ struct flag_settings {
 	unsigned int mask;
 };
 
+static DEFINE_PER_CPU(unsigned long, ddebug_call_count);
+void ddebug_increment_call_count(void)
+{
+	this_cpu_inc(ddebug_call_count);
+}
+EXPORT_SYMBOL(ddebug_increment_call_count);
+
+static void reset_ddebug_call_count(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(ddebug_call_count, cpu) = 0;
+}
+
 static bool ddebug_class_map_in_range(const int class_id,
 				      const struct ddebug_class_map *map);
 static bool ddebug_class_user_in_range(const int class_id,
@@ -101,6 +118,7 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
 	{ _DPRINTK_FLAGS_INCL_STACK, 'd' },
+	{ _DPRINTK_FLAGS_COUNT, 'c' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
@@ -365,10 +383,10 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(newflags & _DPRINTK_FLAGS_PRINT))
+			if (dp->flags & _DPRINTK_FLAGS_BRANCH) {
+				if (!(newflags & _DPRINTK_FLAGS_BRANCH))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (newflags & _DPRINTK_FLAGS_PRINT) {
+			} else if (newflags & _DPRINTK_FLAGS_BRANCH) {
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
@@ -727,6 +745,11 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
+		if (!strcmp(strstrip(query), "reset_stats")) {
+			reset_ddebug_call_count();
+			continue;
+		}
+
 		if (modname)
 			v2pr_info("query %d: module %s \"%s\"\n", i, modname, query);
 		else
@@ -1109,6 +1132,7 @@ static __init int dyndbg_setup(char *str)
 
 __setup("dyndbg=", dyndbg_setup);
 
+
 /*
  * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers the
  * command text from userspace, parses and executes it.
@@ -1266,6 +1290,16 @@ static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp
 	return NULL;
 }
 
+static unsigned long get_ddebug_call_count(void)
+{
+	unsigned long total = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		total += per_cpu(ddebug_call_count, cpu);
+	return total;
+}
+
 /*
  * Seq_ops show method.  Called several times within a read()
  * call from userspace, with ddebug_lock held.  Formats the
@@ -1285,7 +1319,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 	if (p == EPILOGUE_TOKEN) {
-		/* use this soon */
+		unsigned long count = get_ddebug_call_count();
+
+		if (count)
+			seq_printf(m, "#: counted_calls: %lu\n", count);
 		return 0;
 	}
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index c06c16cacb70..27a510fb9950 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -501,7 +501,8 @@ modular_tests=(
 # ==============================================================================
 function GOLDEN_RECORDS {
     cat << 'EO_DYNDBG_GOLDEN_REFS' | {
-#K= 95b249c7ec2cbd5a436f96060b2bee37 FT_grammar_errs.1
+
+#K= 26fd1565f209b383d9f2fbf0b54cd5fc FT_grammar_errs.1
 #K= 200c01632c52a63f6d186da1c6460740 FT_grammar_errs.2
 #K= 7d7141900ce6e32f15c99202309c63a4 FT_grammar_errs.3
 #K= 1bb798a5831d0119789d424ef6cb55c4 FT_grammar_errs.4
@@ -521,7 +522,7 @@ function GOLDEN_RECORDS {
 #K= cb8288d607b0c5282125852f3ab05107 FT_grammar_errs.18
 #K= b371c6ba52503d037dbc43da788af8be FT_grammar_errs.19
 #K= 98e2bd3e4f3da58536496a38ec3e6238 FT_grammar_errs.20
-#K= c4e8b7261811e9fdf0c80fa9e374a29e FT_grammar_errs.21
+#K= 02b210b2646aceb68f3d6d2876a3d57a FT_grammar_errs.21
 #K= 51030cd01ed601a68dd48356902954b1 FT_grammar_errs.22
 #K= af8818de076407d4e7f4e384ba110ac5 FT_grammar_errs.23
 #K= 023ba04ffced833b4776fb4fcaae7755 FT_grammar_errs.24
@@ -541,7 +542,7 @@ function GOLDEN_RECORDS {
 #K= 130bf64b92a5e34d1c4cce98899084e1 FT_grammar_errs.38
 #K= 9681a05658f1a50e3434aa991b5ce992 FT_grammar_errs.39
 #K= 38506317363a188fbb7a417ff50457a9 FT_grammar_errs.40
-#K= c4e8b7261811e9fdf0c80fa9e374a29e FT_grammar_errs.41
+#K= 02b210b2646aceb68f3d6d2876a3d57a FT_grammar_errs.41
 #K= 8c08a8b5cacbf885d022360ed856e7a1 FT_grammar_errs.42
 #K= f0f4d894a49bd2c1856cf4f013f83e54 FT_grammar_errs.43
 #K= 25b92d52cb299fa8d84c5584e490bd97 FT_grammar_errs.44

-- 
2.55.0

