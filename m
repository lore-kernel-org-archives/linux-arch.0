Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34591 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeBVFvl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 00:51:41 -0500
Date: Thu, 22 Feb 2018 06:51:35 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v12 01/22] selftests/x86: Move protecton key selftest to
 arch neutral directory
Message-ID: <20180222055135.6m43xt3mt47sz37q@gmail.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-2-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519264541-7621-2-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Message-ID: <20180222055135.vXAy-WN3HJ6Ewm_NcIBW6bq4CvirnUe7jJHsEQ10si4@z>


* Ram Pai <linuxram@us.ibm.com> wrote:

> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile           |    1 +
>  tools/testing/selftests/vm/pkey-helpers.h     |  223 ++++
>  tools/testing/selftests/vm/protection_keys.c  | 1407 +++++++++++++++++++++++++
>  tools/testing/selftests/x86/Makefile          |    2 +-
>  tools/testing/selftests/x86/pkey-helpers.h    |  223 ----
>  tools/testing/selftests/x86/protection_keys.c | 1407 -------------------------
>  6 files changed, 1632 insertions(+), 1631 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
>  create mode 100644 tools/testing/selftests/vm/protection_keys.c
>  delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
>  delete mode 100644 tools/testing/selftests/x86/protection_keys.c

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
