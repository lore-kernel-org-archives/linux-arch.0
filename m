Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57423 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeCPWPY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:15:24 -0400
Subject: Re: [PATCH v12 10/22] selftests/vm: introduce two arch independent
 abstraction
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-11-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b3a58839-6ded-16eb-79c5-cd26f89790bc@intel.com>
Date: Fri, 16 Mar 2018 15:15:15 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-11-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316221515.yiPI9ra9gm5BYg-hepYw5LH9QOdWjcG6hPKXtU59yhE@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> open_hugepage_file() <- opens the huge page file
> get_start_key() <--  provides the first non-reserved key.
> 

Looks reasonable.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
