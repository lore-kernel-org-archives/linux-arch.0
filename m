Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:41853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751346AbeAVDeh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Jan 2018 22:34:37 -0500
In-Reply-To: <1516326648-22775-4-git-send-email-linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v10,03/27] powerpc: initial pkey plumbing
Message-ID: <3zPxrB60pxz9sNx@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:33 +1100 (AEDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Message-ID: <20180122033433.a3q-T7eGrU7zIo5y9Iav8o3De5aexBXyNufqB-QI2BI@z>

On Fri, 2018-01-19 at 01:50:24 UTC, Ram Pai wrote:
> Basic  plumbing  to   initialize  the   pkey  system.
> Nothing is enabled yet. A later patch will enable it
> once all the infrastructure is in place.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>

Patches 3-27 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/92e3da3cf193fd27996909956c12a2

cheers
