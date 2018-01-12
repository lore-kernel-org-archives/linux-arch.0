From: James Bottomley <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 17/19] qla2xxx: prevent bounds-check bypass via
 speculative execution
Date: Thu, 11 Jan 2018 22:05:55 -0800
Message-ID: <1515737155.3056.48.camel@linux.vnet.ibm.com>
References: <151571798296.27429.7166552848688034184.stgit@dwillia2-desk3.amr.corp.intel.com>
         <151571807774.27429.7382333750792304971.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1515719956.3056.37.camel@linux.vnet.ibm.com>
         <CAPcyv4gb8SpBEYnuc3hULLZdiuUM1Lhc33CBirmXtckD0CsLww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754293AbeALGGG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Jan 2018 01:06:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0C65IUm072248
        for <linux-arch@vger.kernel.org>; Fri, 12 Jan 2018 01:06:06 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fep31k35x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 12 Jan 2018 01:06:05 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Thu, 11 Jan 2018 23:06:05 -0700
In-Reply-To: <CAPcyv4gb8SpBEYnuc3hULLZdiuUM1Lhc33CBirmXtckD0CsLww@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi <linux-scsi@vger.kernel.org>, kernel-hardening@lists.openwall.com, qla2xxx-upstream@qlogic.com, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Thu, 2018-01-11 at 21:38 -0800, Dan Williams wrote:
> On Thu, Jan 11, 2018 at 5:19 PM, James Bottomley
> <jejb@linux.vnet.ibm.com> wrote:
> > 
> > On Thu, 2018-01-11 at 16:47 -0800, Dan Williams wrote:
> > > 
> > > Static analysis reports that 'handle' may be a user controlled
> > > value that is used as a data dependency to read 'sp' from the
> > > 'req->outstanding_cmds' array.
> > 
> > Greg already told you it comes from hardware, specifically the
> > hardware response queue.  If you don't believe him, I can confirm
> > it's quite definitely all copied from the iomem where the mailbox
> > response is, so it can't be a user controlled value (well, unless
> > the user has some influence over the firmware of the
> > qla2xxx  controller, which probably means you have other things to
> > worry about than speculative information leaks).
> 
> I do believe him, and I still submitted this. I'm trying to probe at
> the meta question of where do we draw the line with these especially
> when it costs us relatively little to apply a few line patch? We fix
> theoretical lockdep races, why not theoretical data leak paths?

I think I've lost the thread of what you're after.  I thought you were
asking for the domain experts to look and see if there is the potential
for attack; if there's no theoretical way for a user to influence the
value what's the point of killing speculation?  Furthermore, if the
user could affect that 32 bit value, what they'd actually do is extract
information via the que variable which you didn't fix and which could
be used to compromise the kernel without resorting to side channel
attacks.

What's most puzzling to me is the inconsistency of the positions: if it
doesn't cost that much to turn off speculation, just do it on kernel
entry as Jiří suggested; we can make it a dynamic option and the cloud
providers can do it and the rest of us don't need to bother.  If it
does cost a lot to turn it off as Alan said, then you need us to
identify the cases above where there's no need to disrupt the
speculation pipeline and not turn it off there.  Which is it?

James
