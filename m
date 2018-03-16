Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:38325 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCPWcr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Mar 2018 18:32:47 -0400
Subject: Re: [PATCH v12 20/22] selftests/vm: testcases must restore
 pkey-permissions
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-21-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6f45e32f-a18c-9b33-efaa-aab3c095720f@intel.com>
Date: Fri, 16 Mar 2018 15:32:38 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-21-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180316223238.zXHSDrf-FB6skSL1CShWUlo4r6TsLv7k_XTUsV1ecpc@z>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> Generally the signal handler restores the state of the pkey register
> before returning. However there are times when the read/write operation
> can legitamely fail without invoking the signal handler.  Eg: A
> sys_read() operaton to a write-protected page should be disallowed.  In
> such a case the state of the pkey register is not restored to its
> original state.  The test case is responsible for restoring the key
> register state to its original value.

Oh, that's a good point.

Could we just do this in a common place, though?  Like reset the
register after each test?  Seems more foolproof.
