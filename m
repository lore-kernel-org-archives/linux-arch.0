Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:52431 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYEEJu6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 05:50:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 43/56] microblaze_v2: termbits.h termios.h
Date: Mon, 5 May 2008 11:50:40 +0200
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <9cc0d54a98f25748dc3f16fc3250524d7cd00877.1209897266.git.monstr@monstr.eu> <5d240127ee05c28d5156bfbf305329f9540f6c14.1209897267.git.monstr@monstr.eu>
In-Reply-To: <5d240127ee05c28d5156bfbf305329f9540f6c14.1209897267.git.monstr@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200805051150.41642.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>
Message-ID: <20080505095040.YaQbbOcv0v6WoKNTtt1yh7VMx872dRZo9ExAfqSAoiw@z>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
>  include/asm-microblaze/termbits.h |  203 +++++++++++++++++++++++++++++++++++++
>  include/asm-microblaze/termios.h  |   86 ++++++++++++++++

Both of these are candidates for asm-generic, but I haven't looked
at them in detail yet.

	Arnd <><
