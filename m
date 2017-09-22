Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37465 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdIVGMz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2017 02:12:55 -0400
Date: Fri, 22 Sep 2017 16:12:43 +1000
From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 1/6] mm: introduce an additional vma bit for powerpc
 pkey
Message-ID: <20170922161243.7d03a5b6@firefly.ozlabs.ibm.com>
In-Reply-To: <1505524870-4783-2-git-send-email-linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
        <1505524870-4783-2-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Message-ID: <20170922061243.g5TqPMVz2h5bJ-pz85y_x3XrIYUPRJIJQYtff5LX12U@z>

On Fri, 15 Sep 2017 18:21:05 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Currently only 4bits are allocated in the vma flags to hold 16
> keys. This is sufficient for x86. PowerPC  supports  32  keys,
> which needs 5bits. This patch allocates an  additional bit.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
