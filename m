Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40405 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0G2ANc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2010 20:13:32 -0400
From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 1/4] modpost: support objects with more than 64k sections
Date: Thu, 29 Jul 2010 02:13:26 +0200
References: <1280360876-2571-1-git-send-email-vda.linux@googlemail.com> <1280360876-2571-2-git-send-email-vda.linux@googlemail.com>
In-Reply-To: <1280360876-2571-2-git-send-email-vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <201007290213.26738.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20100729001326.kfqDrr9IdFIKIOUJWXsu-SimYfWQRvw6bG2RXf38oyg@z>

On Thursday 29 July 2010 01:47, Denys Vlasenko wrote:
> This patch makes modpost able to process object files with more than
> 64k sections. Needed for huge kernel builds (allyesconfig, for example)
> with -ffunction-sections.
> 
> Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Andi Kleen <andi@firstfloor.org>

I forgot to mention in the changelog that 64k sections handling
is covered, for example, by this document:

"IA-64 gABI Proposal 74: Section Indexes"
http://www.codesourcery.com/public/cxx-abi/abi/prop-74-sindex.html

-- 
vda
