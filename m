Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:49086 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZGOHjK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2009 03:39:10 -0400
Message-ID: <4A5D8797.10004@petalogix.com>
Date: Wed, 15 Jul 2009 09:39:03 +0200
From: Michal Simek <michal.simek@petalogix.com>
Reply-To: michal.simek@petalogix.com
MIME-Version: 1.0
Subject: asm-generic pgtable.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Linux Kernel list <linux-kernel@vger.kernel.org>, lkml <linux-arch@vger.kernel.org>
Message-ID: <20090715073903.EmQuOjrRvhHw0uF8wJAOU7K53AIqfM25ffbiG5K53lI@z>

Hi Arnd,

I found that we should simplify pgtable.h. There are a lot of generic
functions which use
all archs. Have you look at it or not?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

