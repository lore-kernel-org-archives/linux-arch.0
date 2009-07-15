From: Michal Simek <michal.simek@petalogix.com>
Subject: asm-generic pgtable.h
Date: Wed, 15 Jul 2009 09:39:03 +0200
Message-ID: <4A5D8797.10004@petalogix.com>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753245AbZGOHjP@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Linux Kernel list <linux-kernel@vger.kernel.org>, lkml <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
