Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:57790 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752443AbdKGWrN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Nov 2017 17:47:13 -0500
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
 <87h8u6lf27.fsf@mid.deneb.enyo.de>
 <20171107223953.GB5546@ram.oc3035372033.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <8b970e5b-50e6-bcc1-e8d3-6e3aa8523f55@intel.com>
Date: Tue, 7 Nov 2017 14:47:10 -0800
MIME-Version: 1.0
In-Reply-To: <20171107223953.GB5546@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, Florian Weimer <fw@deneb.enyo.de>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Message-ID: <20171107224710.ypeX_jlI9Mh8InIFqHTG7vQlmLDi2_0WTX7Gxp7WcuI@z>

On 11/07/2017 02:39 PM, Ram Pai wrote:
> 
> As per the current semantics of sys_pkey_free(); the way I understand it,
> the calling thread is saying disassociate me from this key.

No.  It is saying: "this *process* no longer has any uses of this key,
it can be reused".
