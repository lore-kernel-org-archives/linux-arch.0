Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27443 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbeCPWbg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:31:36 -0400
Subject: Re: [PATCH v12 19/22] selftests/vm: detect write violation on a
 mapped access-denied-key page
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-20-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f0468b51-6c2a-0317-2c5e-d48d8a12c374@intel.com>
Date: Fri, 16 Mar 2018 15:31:28 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-20-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316223128.lFZRWNjZ6GF0M3-mAXRPAmk-eAAko3I8kKxa9zODoww@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> detect write-violation on a page to which access-disabled
> key is associated much after the page is mapped.

Acked-by: Dave Hansen <dave.hansen@intel.com>
