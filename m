Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:43900 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbeEBWDY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 May 2018 18:03:24 -0400
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
 <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
 <63086671-3603-1a79-d1a0-63913855456a@intel.com>
 <a42f040c-babf-f1d3-80d2-587afe17b742@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <4bbb5f76-f2ed-c2b7-9b4c-079a6ddf4da2@intel.com>
Date: Wed, 2 May 2018 15:03:22 -0700
MIME-Version: 1.0
In-Reply-To: <a42f040c-babf-f1d3-80d2-587afe17b742@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: linuxram@us.ibm.com, Andy Lutomirski <luto@kernel.org>

On 05/02/2018 02:08 PM, Florian Weimer wrote:
> On 05/02/2018 05:28 PM, Dave Hansen wrote:
>> The other option here that I think we discussed in the past was to have
>> an*explicit*  signal PKRU value.  That way, we can be restrictive by
>> default but allow overrides for special cases like you have.
> 
> That's the patch I posted before (with PKEY_ALLOC_SETSIGNAL).  I'm
> afraid we are going in circles.

Could you remind us why you abandoned that approach and its relative
merits versus this new approach?
