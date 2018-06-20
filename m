Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2529 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753853AbeFTPUY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Jun 2018 11:20:24 -0400
Subject: Re: [PATCH v13 22/24] selftests/vm: testcases must restore
 pkey-permissions
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-23-git-send-email-linuxram@us.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e4e63ab2-2830-9ade-3e5f-6d0f61efbcb6@intel.com>
Date: Wed, 20 Jun 2018 08:20:22 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-23-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180620152022.Y-sLy-A9BvBA9S387liE_MWpOaIuDhhnom88r0S0ACo@z>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> Generally the signal handler restores the state of the pkey register
> before returning. However there are times when the read/write operation
> can legitamely fail without invoking the signal handler.  Eg: A
> sys_read() operaton to a write-protected page should be disallowed.  In
> such a case the state of the pkey register is not restored to its
> original state.  The test case is responsible for restoring the key
> register state to its original value.

Seems fragile.  Can't we just do this in common code?  We could just
loop through and restore the default permissions.  That seems much more
resistant to a bad test case.
