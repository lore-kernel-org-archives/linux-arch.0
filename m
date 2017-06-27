From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC v4 02/17] mm: ability to disable execute permission on a
 key at creation
Date: Tue, 27 Jun 2017 21:32:49 +1000
Message-ID: <1498563169.7935.16.camel@gmail.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
         <1498558319-32466-3-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36257 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdF0Ldm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2017 07:33:42 -0400
In-Reply-To: <1498558319-32466-3-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com

On Tue, 2017-06-27 at 03:11 -0700, Ram Pai wrote:
> Currently sys_pkey_create() provides the ability to disable read
> and write permission on the key, at  creation. powerpc  has  the
> hardware support to disable execute on a pkey as well.This patch
> enhances the interface to let disable execute  at  key  creation
> time. x86 does  not  allow  this.  Hence the next patch will add
> ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> specified.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
