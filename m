Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36146 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423598AbcFHJX7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2016 05:23:59 -0400
Subject: Re: [PATCH 0/9] [v2] System Calls for Memory Protection Keys
References: <20160607204712.594DE00A@viggo.jf.intel.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <6eaf31c0-0c94-6248-2ace-79e7c923a569@gmail.com>
Date: Wed, 8 Jun 2016 11:23:48 +0200
MIME-Version: 1.0
In-Reply-To: <20160607204712.594DE00A@viggo.jf.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
Cc: mtk.manpages@gmail.com, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, arnd@arndb.de
Message-ID: <20160608092348.tx6suDY3rq95FWqnLxIrT8B0cO1OXnB1eFyZXcrOj58@z>

On 06/07/2016 10:47 PM, Dave Hansen wrote:
> Are there any concerns with merging these into the x86 tree so
> that they go upstream for 4.8?  

I believe we still don't have up-to-date man pages, right?
Best from my POV to send them out in parallel with the 
implementation.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
