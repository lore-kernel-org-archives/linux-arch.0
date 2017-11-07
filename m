Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755582AbdKGXol (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Nov 2017 18:44:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA7Ni1OB058347
        for <linux-arch@vger.kernel.org>; Tue, 7 Nov 2017 18:44:41 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e3p8g993p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2017 18:44:40 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 7 Nov 2017 16:44:39 -0700
Date: Tue, 7 Nov 2017 15:44:27 -0800
From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
 <87h8u6lf27.fsf@mid.deneb.enyo.de>
 <20171107223953.GB5546@ram.oc3035372033.ibm.com>
 <8b970e5b-50e6-bcc1-e8d3-6e3aa8523f55@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b970e5b-50e6-bcc1-e8d3-6e3aa8523f55@intel.com>
Message-ID: <20171107234427.GA5659@ram.oc3035372033.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, paulus@samba.org, ebiederm@xmission.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20171107234427.wI1ZreTmFoxnCdGcYG9JIK9xCFIWul1LdOLz3MvwmB8@z>

On Tue, Nov 07, 2017 at 02:47:10PM -0800, Dave Hansen wrote:
> On 11/07/2017 02:39 PM, Ram Pai wrote:
> > 
> > As per the current semantics of sys_pkey_free(); the way I understand it,
> > the calling thread is saying disassociate me from this key.
> 
> No.  It is saying: "this *process* no longer has any uses of this key,
> it can be reused".

ok, in light of the corrected semantics, I see no bug in the implimentation.

> On Mon, Nov 06, 2017 at 10:28:41PM +0100, Florian Weimer wrote:
...
> The problem is a pkey_alloc/pthread_create/pkey_free/pkey_alloc
> sequence.  The pthread_create call makes the new thread inherit the
> access rights of the current thread, but then the key is deallocated.
> Reallocation of the same key will have that thread retain its access
> rights, which is IMHO not correct.

Again.. in light of the corrected semantics --
 the child thread or any thread should not free
a key without cleaning up. 
(a) disassociate the key from its address space
(b) reset the permission on the key across all the threads of the
process.

Because any such uncleaned bits can cause unexpected behavior if the 
same key gets reallocated on sys_pkey_alloc().


-- 
Ram Pai
