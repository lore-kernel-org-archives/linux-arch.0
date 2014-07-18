Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:64773 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbaGRGPB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jul 2014 02:15:01 -0400
Message-ID: <53C8BB6B.5050606@codesourcery.com>
Date: Fri, 18 Jul 2014 14:15:07 +0800
From: Chung-Lin Tang <cltang@codesourcery.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 22/29] nios2: Miscellaneous header files
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <4999408.jEEY9BVX9F@wuerfel> <53C50A87.6000902@codesourcery.com> <4477048.XUlURsz4uq@wuerfel>
In-Reply-To: <4477048.XUlURsz4uq@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, "Joseph S. Myers" <joseph@codesourcery.com>
Message-ID: <20140718061507.PvITN2DUaoR1RGyXZ3folepUtBiOSLbUbGFzZVSxzPg@z>

Hi Arnd,
Considering two other kernel interface issues that appeared earlier in
the context of nios2 glibc/kernel upstreaming:

(1) The 64-bit time_t/timespec issue.
(2) Dropping renameat by default in favor of renameat2

What's the decision for these? Are they delayed to the next release?

Thanks,
Chung-Lin
