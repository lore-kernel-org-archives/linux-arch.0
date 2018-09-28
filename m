Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:15239 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeI1Xzy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Sep 2018 19:55:54 -0400
Date: Fri, 28 Sep 2018 10:30:45 -0700
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v2 0/7] System call table generation support
Message-ID: <20180928173044.GA16322@agluck-desk>
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20180928173045.pj_DHqHExr-yJSl52lgXYYP4LzD2i7EXvIgwRB_02CU@z>

Still does not boot. Last part of console log (nothing unusual
before the "Kernel panic" line):


EFI Variables Facility v0.08 2004-May-17
sd 5:0:0:0: [sdb] 286749488 512-byte logical blocks: (147 GB/137 GiB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdb: sdb1 sdb2
sd 5:0:0:0: [sdb] Attached SCSI disk
NET: Registered protocol family 17
console [netcon0] enabled
netconsole: network logging started
Freeing unused kernel memory: 960K
This architecture does not have kernel memory protection.
Run /init as init process
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
 ]---

-Tony
