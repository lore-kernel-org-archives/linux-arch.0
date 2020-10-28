Return-Path: <SRS0=7t7o=EE=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED72C55179
	for <linux-arch@archiver.kernel.org>; Thu, 29 Oct 2020 00:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C7A20747
	for <linux-arch@archiver.kernel.org>; Thu, 29 Oct 2020 00:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603933053;
	bh=3GDju+YyeSHmZOlUL8Quu28K0NFYnWoAlVT8urBXKzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eRBXHWb7JlSZPEeMfuDUOVkbeAsNsQV/mlsg8vZoLDJiSPVHAz4PmoCbCFySH2dnh
	 7O5Yh/Wj8GDPnFhBxYfK+YtacB3+zKymYfDfENMUbL5DBlk7dkszkJCG3/F0YZ20rc
	 4aAKfcV32CYIxfwN4r1XotVuqo1S1XMJvPb/LUu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgJ2A5c (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731603AbgJ1WRf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A1B82469F;
        Wed, 28 Oct 2020 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603878702;
        bh=3GDju+YyeSHmZOlUL8Quu28K0NFYnWoAlVT8urBXKzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ptcjspj/0/gtfIy/P6pjg0Gm0+c/EMz0VKZtzjNxGaFanOdum6jhky0cuaSA40IA/
         mKMZDfH4pwP1JQONI5Ma0m2rni6wkUrnOMnGO2a5+A/1LTNn4tiwBQYj9JwxJ+6dOL
         0JXKnZzjsWAHCxD+kz7Mlswf2f0beNDhBTYwJZx0=
Date:   Wed, 28 Oct 2020 09:51:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 5/6] arm64: Advertise CPUs capable of running 32-bit
 applcations in sysfs
Message-ID: <20201028095136.GA27796@willie-the-truck>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-6-will@kernel.org>
 <20201028083746.GA1854746@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028083746.GA1854746@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 28, 2020 at 09:37:46AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Oct 27, 2020 at 09:51:17PM +0000, Will Deacon wrote:
> > Since 32-bit applications will be killed if they are caught trying to
> > execute on a 64-bit-only CPU in a mismatched system, advertise the set
> > of 32-bit capable CPUs to userspace in sysfs.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  .../ABI/testing/sysfs-devices-system-cpu      |  8 ++++++++
> >  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > index b555df825447..19893fb8e870 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> > +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > @@ -472,6 +472,14 @@ Description:	AArch64 CPU registers
> >  		'identification' directory exposes the CPU ID registers for
> >  		 identifying model and revision of the CPU.
> >  
> > +What:		/sys/devices/system/cpu/aarch32_el0
> > +Date:		October 2020
> > +Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
> > +Description:	Identifies the subset of CPUs in the system that can execute
> > +		AArch32 (32-bit ARM) applications. If absent, then all or none
> > +		of the CPUs can execute AArch32 applications and execve() will
> > +		behave accordingly.
> 
> How is this value represented?  A hint here would be nice.

It's in the same format as
/sys/devices/system/cpu/{online,offline,possible,present}, so I'll just say
that (although the text for those doesn't seem to specify it either...).

> >  What:		/sys/devices/system/cpu/cpu#/cpu_capacity
> >  Date:		December 2016
> >  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 2e2219cbd54c..9f29d4d1ef7e 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -67,6 +67,7 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/sort.h>
> >  #include <linux/stop_machine.h>
> > +#include <linux/sysfs.h>
> >  #include <linux/types.h>
> >  #include <linux/mm.h>
> >  #include <linux/cpu.h>
> > @@ -1236,6 +1237,24 @@ bool system_has_mismatched_32bit_el0(void)
> >  	return fld == ID_AA64PFR0_EL0_64BIT_ONLY;
> >  }
> >  
> > +static ssize_t aarch32_el0_show(struct kobject *kobj,
> > +				struct kobj_attribute *attr, char *buf)
> > +{
> > +	const struct cpumask *mask = system_32bit_el0_cpumask();
> > +	return sprintf(buf, "%*pbl\n", cpumask_pr_args(mask));
> 
> sysfs_emit()?
> 
> And a blank line to make checkpatch.pl happy :)

Hehe, yeah ok.

> > +}
> > +static const struct kobj_attribute aarch32_el0_attr = __ATTR_RO(aarch32_el0);
> 
> DEVICE_ATTR_RO()?
> 
> > +
> > +static int __init aarch32_el0_sysfs_init(void)
> > +{
> > +	if (!__allow_mismatched_32bit_el0)
> > +		return 0;
> > +
> > +	return sysfs_create_file(&cpu_subsys.dev_root->kobj,
> > +				 &aarch32_el0_attr.attr);
> 
> device_create_file() please, dev_root is a struct device, no need to
> "thunk" down to a "raw" sysfs call.

Totally missed I had a struct device in my hand, so hopefully that will tidy
things up a little bit.

Cheers,

Will
