Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:27346 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYGOKD6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2008 06:03:58 -0400
Subject: Re: [PATCH 01/14] Introduce cpu_enabled_map and friends
From: Andi Kleen <andi@firstfloor.org>
References: <20080715023344.2528.1836.stgit@blender.achiang>
	<20080715023349.2528.9423.stgit@blender.achiang>
	<20080715031512.GF14894@parisc-linux.org>
Date: Tue, 15 Jul 2008 12:03:27 +0200
In-Reply-To: <20080715031512.GF14894@parisc-linux.org> (Matthew Wilcox's message of "Mon, 14 Jul 2008 21:15:12 -0600")
Message-ID: <87wsjnxy4w.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alex Chiang <achiang@hp.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Message-ID: <20080715100327.OjHD2L7dsn2ctYPZkVRxvnE2ihruLshL47zkXV06Fc0@z>

Matthew Wilcox <matthew@wil.cx> writes:
>
> I don't understand why we want to know about these CPUs.  Surely they
> should be 'possible', but not 'present'?  What useful thing can Linux do
> with them?

He explained it in the intro, near the end (I nearly complained about
this too when I hadn't finished reading it completely :):

|The big picture implication is that we can allow userspace
|to interact with disabled CPUs. In this particular example,
|we provide a knob that lets a sysadmin schedule any present
|CPU for firmware deconfiguration or enablement.

The reason sounds pretty exotic, but ok.

-Andi
