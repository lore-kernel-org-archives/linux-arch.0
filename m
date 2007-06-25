Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60223 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbXFYN5G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 09:57:06 -0400
Message-ID: <467FC985.7080703@anagramm.de>
Date: Mon, 25 Jun 2007 15:56:21 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
Subject: Re: [PATCH] cross-architecture ELF clean up
References: <20070620230854.246399397@goop.org>  <20070620230902.387008536@goop.org> <1182762166.12109.19.camel@pmac.infradead.org> <Pine.LNX.4.64.0706251538540.4386@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0706251538540.4386@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Eric W. Biederman" <ebiederm@xmission.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Hi, Roman!

Roman Zippel schrieb:
> Hi,
> 
> On Mon, 25 Jun 2007, David Woodhouse wrote:
> 
>> On Wed, 2007-06-20 at 16:08 -0700, Jeremy Fitzhardinge wrote:
>>> This patch cleans up the ELF headers and their users.  It does several
>>> related things:
>> Looks good. We can get away with exporting a lot less of this to
>> userspace too, can't we?
> 
> glibc provides its own version, so it doesn't has to be exported at all.

AFAIK the glibc folks want to rely more on the linux kernel headers
in the future and not provide more or less redundant headers anymore...
Please talk to them about the future plans.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
