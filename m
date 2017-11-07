Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754904AbdKGBWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2017 20:22:30 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA71JQ30088420
        for <linux-arch@vger.kernel.org>; Mon, 6 Nov 2017 20:22:30 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e32cb1whu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2017 20:22:29 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Mon, 6 Nov 2017 20:22:28 -0500
Date: Mon, 6 Nov 2017 17:22:18 -0800
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efpbm706.fsf@mid.deneb.enyo.de>
Message-ID: <20171107012218.GA5546@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Message-ID: <20171107012218.PxRYwLqIImvIvWInkIDZQTlcGBa7-9rtr3KTG8nMLJg@z>

On Mon, Nov 06, 2017 at 10:28:41PM +0100, Florian Weimer wrote:
> * Ram Pai:
> 
> > Testing:
> > -------
> > This patch series has passed all the protection key
> > tests available in the selftest directory.The
> > tests are updated to work on both x86 and powerpc.
> > The selftests have passed on x86 and powerpc hardware.
> 
> How do you deal with the key reuse problem?  Is it the same as x86-64,
> where it's quite easy to accidentally grant existing threads access to
> a just-allocated key, either due to key reuse or a changed init_pkru
> parameter?

I am not sure how on x86-64, two threads get allocated the same key
at the same time? the key allocation is guarded under the mmap_sem
semaphore. So there cannot be a race where two threads get allocated
the same key.

Can you point me to the issue, if it is already discussed somewhere?

As far as the semantics is concerned, a key allocated in one thread's
context has no meaning if used in some other threads context within the
same process.  The app should not try to re-use a key allocated in a
thread's context in some other threads's context.

> 
> What about siglongjmp from a signal handler?

On powerpc there is some relief.  the permissions on a key can be
modified from anywhere, including from the signal handler, and the
effect will be immediate.  You dont have to wait till the
signal handler returns for the key permissions to be restore.

also after return from the sigsetjmp();
possibly caused by siglongjmp(), the program can restore the permission
on any key.

Atleast that is my theory. Can you give me a testcase; if you have one
handy.

> 
>   <https://urldefense.proofpoint.com/v2/url?u=https-3A__sourceware.org_bugzilla_show-5Fbug.cgi-3Fid-3D22396&d=DwIBAg&c=jf_iaSHvJObTbx-siA1ZOg&r=m-UrKChQVkZtnPpjbF6YY99NbT8FBByQ-E-ygV8luxw&m=UmfbMQc2yyiSfzGDF9J2vFgiKDkVtkdf5xW3qdVeCVs&s=MuUgK3t4Ay8rjmIK7YgK94HZsp8IRG7pJwU6n-GnZn0&e=>
> 
> I wonder if it's possible to fix some of these things before the exact
> semantics of these interfaces are set in stone.

Will try.

RP
