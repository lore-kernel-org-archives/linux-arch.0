From: James Bottomley <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/18] qla2xxx: prevent bounds-check bypass via
 speculative execution
Date: Fri, 12 Jan 2018 07:25:11 -0800
Message-ID: <1515770711.3922.5.camel@linux.vnet.ibm.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
         <151520104838.32271.7038801336240727574.stgit@dwillia2-desk3.amr.corp.intel.com>
         <20180106090322.GF4380@kroah.com>
         <CAPcyv4jQjwa5X6ctO7bU1Z3hfRGRTa6gDO3pSSo_HQHkjg4MFg@mail.gmail.com>
         <20180112072758.GD25517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933926AbeALPZW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Jan 2018 10:25:22 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0CFOpH6106505
        for <linux-arch@vger.kernel.org>; Fri, 12 Jan 2018 10:25:20 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fewbqs49c-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 12 Jan 2018 10:25:20 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Fri, 12 Jan 2018 08:25:19 -0700
In-Reply-To: <20180112072758.GD25517@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi <linux-scsi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, qla2xxx-upstream@qlogic.com, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Fri, 2018-01-12 at 08:27 +0100, Greg KH wrote:
> On Thu, Jan 11, 2018 at 02:15:12PM -0800, Dan Williams wrote:
> > 
> > On Sat, Jan 6, 2018 at 1:03 AM, Greg KH <gregkh@linuxfoundation.org
> > > wrote:
> > > 
> > > On Fri, Jan 05, 2018 at 05:10:48PM -0800, Dan Williams wrote:
> > > > 
> > > > Static analysis reports that 'handle' may be a user controlled
> > > > value that is used as a data dependency to read 'sp' from the
> > > > 'req->outstanding_cmds' array.  In order to avoid potential
> > > > leaks of kernel memory values, block speculative execution of
> > > > the instruction stream that could issue reads based on an
> > > > invalid value of 'sp'. In this case 'sp' is directly
> > > > dereferenced later in the function.
> > > 
> > > I'm pretty sure that 'handle' comes from the hardware, not from
> > > userspace, from what I can tell here.  If we want to start
> > > auditing __iomem data sources, great!  But that's a bigger task,
> > > and one I don't think we are ready to tackle...
> > 
> > I think it falls in the hygiene bucket of shutting off an array
> > index from a source that could be under attacker control. Should we
> > leave this one un-patched while we decide if we generally have a
> > problem with trusting completion 'tags' from hardware? My vote is
> > patch it for now.
> 
> Hah, if you are worried about "tags" from hardware, we have a lot
> more auditing to do, right? 

We'd also have a lot more to do: the assumption would have to be
malicious hardware and most hardware has access to fairly vital stuff
directly.  I really don't think we have to worry about side channel
attacks from hardware until the direct attack vector is closed.

James
