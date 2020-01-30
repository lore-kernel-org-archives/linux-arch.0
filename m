From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v18 00/24] selftests, powerpc, x86: Memory Protection Keys
Date: Thu, 30 Jan 2020 13:51:45 -0800
Message-ID: <5887a858-b669-752e-b65e-ed7d7ded34aa@intel.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28915 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgA3Vvr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 16:51:47 -0500
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au

On 1/29/20 10:36 PM, Sandipan Das wrote:
> v18:
> 	(1) Fixed issues with x86 multilib builds based on
> 	    feedback from Dave.
> 	(2) Moved patch 2 to the end of the series.

These (finally) build and run successfully for me on an x86 system with
protection keys.  Feel free to add my Tested-by, and Acked-by.

FWIW, I don't think look perfect, but my standards are lower for
selftests/ than normal kernel code. :)
