From: James Hogan <james@albanarts.com>
Subject: Re: [GIT PULL] User API Disintegrate: Preparatory patches
Date: Mon, 22 Oct 2012 12:50:24 +0100
Message-ID: <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>
References: <18137.1349203013@warthog.procyon.org.uk>
	<CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38829 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2JVLuZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Oct 2012 07:50:25 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1582843lbo.19
        for <linux-arch@vger.kernel.org>; Mon, 22 Oct 2012 04:50:24 -0700 (PDT)
In-Reply-To: <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, arnd@arndb.de, hpa@zytor.com, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 17 October 2012 09:42, James Hogan <james@albanarts.com> wrote:
> On 2 October 2012 19:36, David Howells <dhowells@redhat.com> wrote:
>> The patches herein prepare for the extraction of the Userspace API bits from
>> the various header files named in the Kbuild files.
>>
>> [IMPORTANT NOTE!  These patches may need regenerating if the header files
>>  change too much.  This doesn't normally take very long to do as the
>>  disintegration procedure is almost entirely scripted.]
>
> Hi David,
>
> Any chance you (or somebody else) can point me towards your latest
> scripts for all this UAPI disintegration work? They don't seem to be
> in the kernel tree, and the only scripts I can find are from 2011 so I
> guess they're probably a bit out of date.

Ping... Please can you point me to the scripts you've been using David?

Thanks
James Hogan
