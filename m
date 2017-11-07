Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753070AbdKGWkF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Nov 2017 17:40:05 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA7MdbjW073489
        for <linux-arch@vger.kernel.org>; Tue, 7 Nov 2017 17:40:05 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e3m26d0nv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2017 17:40:04 -0500
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 7 Nov 2017 17:40:03 -0500
Date: Tue, 7 Nov 2017 14:39:53 -0800
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
 <87h8u6lf27.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8u6lf27.fsf@mid.deneb.enyo.de>
Message-ID: <20171107223953.GB5546@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Message-ID: <20171107223953.ExU5fMJhSHD_6aVcigFDMH3v4Vknw-SO9ng5cjMA6IY@z>

On Tue, Nov 07, 2017 at 08:32:16AM +0100, Florian Weimer wrote:
> * Ram Pai:
> 
> > On Mon, Nov 06, 2017 at 10:28:41PM +0100, Florian Weimer wrote:
> >> * Ram Pai:
> >> 
> >> > Testing:
> >> > -------
> >> > This patch series has passed all the protection key
> >> > tests available in the selftest directory.The
> >> > tests are updated to work on both x86 and powerpc.
> >> > The selftests have passed on x86 and powerpc hardware.
> >> 
> >> How do you deal with the key reuse problem?  Is it the same as x86-64,
> >> where it's quite easy to accidentally grant existing threads access to
> >> a just-allocated key, either due to key reuse or a changed init_pkru
> >> parameter?
> >
> > I am not sure how on x86-64, two threads get allocated the same key
> > at the same time? the key allocation is guarded under the mmap_sem
> > semaphore. So there cannot be a race where two threads get allocated
> > the same key.
> 
> The problem is a pkey_alloc/pthread_create/pkey_free/pkey_alloc
> sequence.  The pthread_create call makes the new thread inherit the
> access rights of the current thread, but then the key is deallocated.
> Reallocation of the same key will have that thread retain its access
> rights, which is IMHO not correct.

(Dave Hansen: please correct me if I miss-speak below)

As per the current semantics of sys_pkey_free(); the way I understand it,
the calling thread is saying disassociate me from this key. Other
threads continue to be associated with the key and could continue to
get key-faults, but this calling thread will not get key-faults on that
key any more.

Also the key should not get reallocated till all the threads in the process
have disassocated from the key; by calling sys_pkey_free().
