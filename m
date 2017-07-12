Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58191 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752301AbdGLWl0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jul 2017 18:41:26 -0400
Message-ID: <1499899228.2865.43.camel@kernel.crashing.org>
Subject: Re: [RFC v5 11/38] mm: introduce an additional vma bit for powerpc
 pkey
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Jul 2017 08:40:28 +1000
In-Reply-To: <20170712222331.GD5525@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
         <1499289735-14220-12-git-send-email-linuxram@us.ibm.com>
         <290636b0-aafd-9bcd-d309-4cff41ce923c@intel.com>
         <20170712222331.GD5525@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, Dave Hansen <dave.hansen@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170712224028.gCuKcX5CdBqn_xADed5rZ8FGCO5rmqyia8Sar-K-Dzo@z>

On Wed, 2017-07-12 at 15:23 -0700, Ram Pai wrote:
> Just copying over makes checkpatch.pl unhappy. It exceeds 80 columns.

Which is fine to ignore in a case like that where you remain consistent
with the existing code.

Ben.
