From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 0/2] Stop some of the abuse of BUG() where compile time
 checks should be used.
Date: Wed, 23 Nov 2011 15:57:37 -0800
Message-ID: <CA+55aFwjUVhff6jADOSvAn=t4CTVf4ZODTNm7M6vYcmG6TikPA@mail.gmail.com>
References: <1322092017-21471-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60832 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab1KWX6A (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2011 18:58:00 -0500
In-Reply-To: <1322092017-21471-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Rientjes <rientjes@google.com>, DM <dm.n9107@gmail.com>, David Howells <dhowells@redhat.com>, David Daney <david.daney@cavium.com>

Btw, would it possibly make sense to make the string more useful?

For example using __FILE__ and __LINE__, or possibly letting the user
of the BUILD_BUG() give a string ("Using HMASK without
CONFIG_HUGEPAGE").

Whatever. It's bikeshedding - what would probably be more important
would be to get this into linux-next so that we find out whether there
are any compile issues with it on other platforms or compiler
versions.

                  Linus
