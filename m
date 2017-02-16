From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] kretprobes: ensure probe location is at function
 entry
Date: Thu, 16 Feb 2017 13:21:02 +0530
Message-ID: <20170216075102.GB4515@naverao1-tp.localdomain>
References: <20170215175346.GE3169@naverao1-tp.localdomain>
 <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170216083944.ef84cd2d5cdb271372aef639@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52021 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754009AbdBPHwA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Feb 2017 02:52:00 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1G7ckfq122571
        for <linux-arch@vger.kernel.org>; Thu, 16 Feb 2017 02:51:59 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28mq9kyvw2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 16 Feb 2017 02:51:59 -0500
Received: from localhost
        by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 16 Feb 2017 17:51:56 +1000
Content-Disposition: inline
In-Reply-To: <20170216083944.ef84cd2d5cdb271372aef639@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 2017/02/16 08:39AM, Masami Hiramatsu wrote:
> On Wed, 15 Feb 2017 23:47:52 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > kretprobes can be registered by specifying an absolute address or by
> > specifying offset to a symbol. However, we need to ensure this falls at
> > function entry so as to be able to determine the return address.
> > 
> > Validate the same during kretprobe registration. By default, there
> > should not be any offset from a function entry, as determined through a
> > kallsyms_lookup(). Introduce arch_function_offset_within_entry() as a
> > way for architectures to override this.
> > 
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, Masami! I am cc'ing linux-arch in case any other architectures 
need to override the arch-specific helper with a custom offset.

- Naveen

> 
> Thanks!
> 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> > powerpc64 ABIv2 will need to use the over-ride as we want to use the
> > local entry point which will be at an offset of 8 bytes from the
> > (global) entry point. I have a patch that I will post separately.
> > 
> > Thanks,
> > Naveen
> > 
> >  include/linux/kprobes.h |  1 +
> >  kernel/kprobes.c        | 13 +++++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index 8f6849084248..0c2489435117 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -266,6 +266,7 @@ extern int arch_init_kprobes(void);
> >  extern void show_registers(struct pt_regs *regs);
> >  extern void kprobes_inc_nmissed_count(struct kprobe *p);
> >  extern bool arch_within_kprobe_blacklist(unsigned long addr);
> > +extern bool arch_function_offset_within_entry(unsigned long offset);
> >  
> >  extern bool within_kprobe_blacklist(unsigned long addr);
> >  
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 43460104f119..72ecbf5a6312 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1834,12 +1834,25 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
> >  }
> >  NOKPROBE_SYMBOL(pre_handler_kretprobe);
> >  
> > +bool __weak arch_function_offset_within_entry(unsigned long offset)
> > +{
> > +	return !offset;
> > +}
> > +
> >  int register_kretprobe(struct kretprobe *rp)
> >  {
> >  	int ret = 0;
> >  	struct kretprobe_instance *inst;
> >  	int i;
> >  	void *addr;
> > +	unsigned long offset;
> > +
> > +	addr = kprobe_addr(&rp->kp);
> > +	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
> > +		return -EINVAL;
> > +
> > +	if (!arch_function_offset_within_entry(offset))
> > +		return -EINVAL;
> >  
> >  	if (kretprobe_blacklist_size) {
> >  		addr = kprobe_addr(&rp->kp);
> > -- 
> > 2.11.0
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 
