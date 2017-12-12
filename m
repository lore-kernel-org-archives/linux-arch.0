From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: pkeys: Support setting access rights for signal handlers
Date: Tue, 12 Dec 2017 15:13:24 -0800
Message-ID: <20171212231324.GE5460@ram.oc3035372033.ibm.com>
References: <5fee976a-42d4-d469-7058-b78ad8897219@redhat.com>
 <c034f693-95d1-65b8-2031-b969c2771fed@intel.com>
 <5965d682-61b2-d7da-c4d7-c223aa396fab@redhat.com>
 <aa4d127f-0315-3ac9-3fdf-1f0a89cf60b8@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752690AbdLLXNd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Dec 2017 18:13:33 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBCN9BU3110230
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2017 18:13:33 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2etr03sb8s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2017 18:13:32 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 12 Dec 2017 18:13:32 -0500
Content-Disposition: inline
In-Reply-To: <aa4d127f-0315-3ac9-3fdf-1f0a89cf60b8@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-mm <linux-mm@kvack.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-x86_64@vger.kernel.org, Linux API <linux-api@vger.kernel.org>

On Mon, Dec 11, 2017 at 08:13:12AM -0800, Dave Hansen wrote:
> On 12/09/2017 10:42 PM, Florian Weimer wrote:
> >> My only nit with this is whether it is the *right* interface.  The 
> >> signal vs. XSAVE state thing is pretty x86 specific and I doubt
> >> that this will be the last feature that we encounter that needs
> >> special signal behavior.
> > 
> > The interface is not specific to XSAVE.  To generic code, only the
> > two signal mask manipulation functions are exposed.  And I expect
> > that we're going to need that for other (non-x86) implementations
> > because they will have the same issue because the signal handler
> > behavior will be identical.
> 
> Let's check with the other implementation...
> 
> Ram, this is a question about the signal handler behavior on POWER.  I
> thought you ended up having different behavior in signal handlers than x86.

On POWER, the value of the pkey_read() i.e contents the AMR
register(pkru equivalent), is always the same regardless of its
context; signal handler or not.

In other words, the permission of any allocated key will not
reset in a signal handler context.

I was not aware that x86 would reset the key permissions in signal
handler.  I think, the proposed behavior for PKEY_ALLOC_SETSIGNAL should
actually be the default behavior.


RP
