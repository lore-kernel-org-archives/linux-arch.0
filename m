Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33139 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfLRUsh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 15:48:37 -0500
Subject: Re: [PATCH v15 00/24] selftests, powerpc, x86: Memory Protection Keys
References: <cover.1576645161.git.sandipan@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ab2d5c1f-3103-78e3-6c5d-990494ee3580@intel.com>
Date: Wed, 18 Dec 2019 12:48:11 -0800
MIME-Version: 1.0
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Message-ID: <20191218204811.s04uC-S6fvDBcuqQ6yBAaspP3R59j_7Dx7n3FYcyrwc@z>

On 12/17/19 11:51 PM, Sandipan Das wrote:
> Testing
> -------
> Verified for correctness on powerpc. Need help with x86 testing as I
> do not have access to a Skylake server. Client platforms like Coffee
> Lake do not have the required feature bits set in CPUID.

FWIW, you can get a Skylake Server instance from cloud providers.  I
spooled up an Amazon EC3 instance once to run these tests.  It think it
cost me $0.08.
