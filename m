Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:40838 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeIQRc5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Sep 2018 13:32:57 -0400
Date: Mon, 17 Sep 2018 12:05:48 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH] [RFC] making uapi/linux/elfcore.h useful again
In-Reply-To: <20180914113929.953895-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1809171204350.13789@digraph.polyomino.org.uk>
References: <20180914113929.953895-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>, libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180917120548.pZUj_K5DBE88bHfotlsDdQ2wrU002lKNk55kAlFpBEM@z>

On Fri, 14 Sep 2018, Arnd Bergmann wrote:

> +typedef unsigned long elf_greg_t;

Does that need to be unsigned long long for x32?  (At least glibc thinks 
so; I've not tested what an x32 core dump actually looks like, but to be 
useful it certainly ought to have 64-bit registers.)

-- 
Joseph S. Myers
joseph@codesourcery.com
