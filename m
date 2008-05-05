From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 43/56] microblaze_v2: termbits.h termios.h
Date: Mon, 5 May 2008 11:50:40 +0200
Message-ID: <200805051150.41642.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <9cc0d54a98f25748dc3f16fc3250524d7cd00877.1209897266.git.monstr@monstr.eu> <5d240127ee05c28d5156bfbf305329f9540f6c14.1209897267.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757746AbYEEJvN@vger.kernel.org>
In-Reply-To: <5d240127ee05c28d5156bfbf305329f9540f6c14.1209897267.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>
List-Id: linux-arch.vger.kernel.org

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> =A0include/asm-microblaze/termbits.h | =A0203 +++++++++++++++++++++++=
++++++++++++++
> =A0include/asm-microblaze/termios.h =A0| =A0 86 ++++++++++++++++

Both of these are candidates for asm-generic, but I haven't looked
at them in detail yet.

	Arnd <><
