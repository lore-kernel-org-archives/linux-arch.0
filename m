Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:47394 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbXFOMnp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Jun 2007 08:43:45 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
Date: Fri, 15 Jun 2007 14:40:09 +0200
References: <200706150159.l5F1xNgM000459@hera.kernel.org> <200706151355.57464.ak@suse.de> <200706151403.53855.arnd@arndb.de>
In-Reply-To: <200706151403.53855.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706151440.10273.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>


> That is broken on all non-x86 architectures, 

It cannot be broken, it just might be somewhat slower

-Andi
