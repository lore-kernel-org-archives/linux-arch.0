From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Tue, 13 Nov 2012 09:55:52 +0000
Message-ID: <201211130955.52429.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211121910.09395.arnd@arndb.de> <50A2165F.4010202@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57643 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2KMJz4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Nov 2012 04:55:56 -0500
In-Reply-To: <50A2165F.4010202@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Tuesday 13 November 2012, James Hogan wrote:
> Hmm, I found the thread "ARM unaligned MMIO access with
> attribute((packed))" which appears to be one of the problems you're
> referring to. With some experimentation I can't reproduce this kind of
> problem with our current compiler, but it's certainly cause for concern.

Right. The main problem for reproducing this is that it depends on
undefined behavior in C (casting between pointers to types of different
alignment), and what gcc does in this case has changed a couple of times.

	Arnd
