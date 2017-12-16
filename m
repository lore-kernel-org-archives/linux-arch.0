Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756857AbdLPPJS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 Dec 2017 10:09:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBGF8c5B187904
        for <linux-arch@vger.kernel.org>; Sat, 16 Dec 2017 10:09:18 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2evx0cumup-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 16 Dec 2017 10:09:17 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Sat, 16 Dec 2017 10:09:17 -0500
Date: Sat, 16 Dec 2017 07:09:10 -0800
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: pkeys: Support setting access rights for signal handlers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <5965d682-61b2-d7da-c4d7-c223aa396fab@redhat.com>
 <aa4d127f-0315-3ac9-3fdf-1f0a89cf60b8@intel.com>
 <20171212231324.GE5460@ram.oc3035372033.ibm.com>
 <9dc13a32-b1a6-8462-7e19-cfcf9e2c151e@redhat.com>
 <20171213113544.GG5460@ram.oc3035372033.ibm.com>
 <9f86d79e-165a-1b8e-32dd-7e4e8579da59@redhat.com>
 <c220f36f-c04a-50ae-3fd7-2c6245e27057@intel.com>
 <93153ac4-70f0-9d17-37f1-97b80e468922@redhat.com>
 <20171214001756.GA5471@ram.oc3035372033.ibm.com>
 <cf13f6e0-2405-4c58-4cf1-266e8baae825@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf13f6e0-2405-4c58-4cf1-266e8baae825@redhat.com>
Message-ID: <20171216150910.GA5461@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-mm <linux-mm@kvack.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-x86_64@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Message-ID: <20171216150910.zdyL0cDxBT-BKQr60ObvRpNRmWS45KC_NGzfSuJgNmM@z>

On Thu, Dec 14, 2017 at 12:21:44PM +0100, Florian Weimer wrote:
> On 12/14/2017 01:17 AM, Ram Pai wrote:
> >On Wed, Dec 13, 2017 at 04:40:11PM +0100, Florian Weimer wrote:
> >>On 12/13/2017 04:22 PM, Dave Hansen wrote:
> >>>On 12/13/2017 07:08 AM, Florian Weimer wrote:
> >>>>Okay, this model is really quite different from x86.  Is there a
> >>>>good reason for the difference?
> >>>
> >>>Yes, both implementations are simple and take the "natural" behavior.
> >>>x86 changes XSAVE-controlled register values on entering a signal, so we
> >>>let them be changed (including PKRU).  POWER hardware does not do this
> >>>to its PKRU-equivalent, so we do not force it to.
> >>
> >>Whuy?  Is there a technical reason not have fully-aligned behavior?
> >>Can POWER at least implement the original PKEY_ALLOC_SETSIGNAL
> >>semantics (reset the access rights for certain keys before switching
> >>to the signal handler) in a reasonably efficient manner?
> >
> >This can be done on POWER. I can also change the behavior on POWER
> >to exactly match x86; i.e reset the value to init value before
> >calling the signal handler.
> 
> Maybe we can implement a compromise?
> 
> Assuming I got the attached patch right, it implements PKRU
> inheritance in signal handlers, similar to what you intend to
> implement for POWER.

Ok.

> It still restores the PKRU register value upon
> regular exit from the signal handler, which I think is something we
> should keep.

On x86, the pkru value is restored, on return from the signal handler,
to the value before the signal handler was called. right?

In other words, if 'x' was the value when signal handler was called, it
will be 'x' when return from the signal handler.

If correct, than it is consistent with the behavior on POWER.

> 
> I think we still should add a flag, so that applications can easily
> determine if a kernel has this patch.  Setting up a signal handler,
> sending the signal, and thus checking for inheritance is a bit
> involved, and we'd have to do this in the dynamic linker before we
> can use pkeys to harden lazy binding.  The flag could just be a
> no-op, apart from the lack of an EINVAL failure if it is specified.

Sorry. I am little confused.  What should I implement on POWER? 
PKEY_ALLOC_SETSIGNAL semantics?

Let me know. Thanks for driving this to some consistency.
RP
