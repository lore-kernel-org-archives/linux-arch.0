Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:37439 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeCPWa7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:30:59 -0400
Subject: Re: [PATCH v12 18/22] selftests/vm: associate key on a mapped page
 and detect write violation
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-19-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <cf9ccf32-724c-e25c-4226-3c9c670bc4aa@intel.com>
Date: Fri, 16 Mar 2018 15:30:50 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-19-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316223050.CYAkIa2mdmxmM8sWp3tyR_gZvx8nT0--KqCDL93v9jQ@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> detect write-violation on a page to which write-disabled
> key is associated much after the page is mapped.

The more tests the merrier.

Acked-by: Dave Hansen <dave.hansen@intel.com>
