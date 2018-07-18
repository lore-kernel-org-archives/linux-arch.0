Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:17245 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbeGRQFg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jul 2018 12:05:36 -0400
Subject: Re: [PATCH v14 04/22] selftests/vm: move arch-specific definitions to
 arch-specific header
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-5-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <cbe905d6-bff5-cbe0-831b-13c76334ff1a@intel.com>
Date: Wed, 18 Jul 2018 08:27:08 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-5-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180718152708.rpfig8uydSojT54HRE3L4NZChkVOkfRULKlPMIQ8Q_A@z>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> In preparation for multi-arch support, move definitions which have
> arch-specific values to x86-specific header.

Acked-by: Dave Hansen <dave.hansen@intel.com>
