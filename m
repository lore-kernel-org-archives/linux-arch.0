Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:23187 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbeGRQKm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jul 2018 12:10:42 -0400
Subject: Re: [PATCH v14 06/22] selftests/vm: typecast the pkey register
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-7-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <8c468c61-615a-dd0d-2b73-d3218f38e3e4@intel.com>
Date: Wed, 18 Jul 2018 08:32:10 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-7-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180718153210.dYTwXI7TgtecjApZJGHgVJIDKsgA4HHCHSkT_TAW8dA@z>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> This is in preparation to accomadate a differing size register
> across architectures.

This is pretty fugly, and reading it again, I wonder whether we should
have just made it 64-bit, at least in all the printk's.  Or even

	prink("pk reg: %*llx\n", PKEY_FMT_LEN, pkey_reg);

But, I don't _really_ care in the end.

Acked-by: Dave Hansen <dave.hansen@intel.com>
