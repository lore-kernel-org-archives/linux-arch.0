Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:18097 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbeGRQX7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jul 2018 12:23:59 -0400
Subject: Re: [PATCH v14 10/22] selftests/vm: fix alloc_random_pkey() to make
 it really random
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-11-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b33e0850-f3ec-86b8-69e8-9e6afb289058@intel.com>
Date: Wed, 18 Jul 2018 08:45:26 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-11-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180718154526.BqG6Isg-5EISH3R1nNiVwbnHox5efkXRlgZa8cdjAno@z>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> alloc_random_pkey() was allocating the same pkey every time.
> Not all pkeys were geting tested. fixed it.

This fixes a real issue but also unnecessarily munges whitespace.  If
you rev these again, please fix the munging.  Otherwise:

Acked-by: Dave Hansen <dave.hansen@intel.com>
