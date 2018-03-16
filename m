Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64206 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCPWaV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:30:21 -0400
Subject: Re: [PATCH v12 17/22] selftests/vm: associate key on a mapped page
 and detect access violation
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-18-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <bec09b77-ca65-5724-1191-a21f4cfa7cd3@intel.com>
Date: Fri, 16 Mar 2018 15:30:10 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-18-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316223010.ma3mz97uaGlvFan7w_EABo7NagsbI_M2VwKe0p_vnNo@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> detect access-violation on a page to which access-disabled
> key is associated much after the page is mapped.

Looks fine to me.  Did this actually find a bug for you?

Acked-by: Dave Hansen <dave.hansen@intel.com>
