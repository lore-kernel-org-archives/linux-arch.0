Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477AbYDJWQg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Apr 2008 18:16:36 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1207865183.22001.49.camel@brick>
References: <1207865183.22001.49.camel@brick> <1207864537.22001.47.camel@brick> <1207856646.22001.25.camel@brick> <11527.1207863801@redhat.com> <11814.1207864864@redhat.com>
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned access
Date: Thu, 10 Apr 2008 23:15:58 +0100
Message-ID: <11907.1207865758@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410221558.EwBfD--0FXNjYmZXdjFlrEzUVMH-fdl4re25Ry1OobE@z>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Expands to int, not unsigned int, I think that cast is still needed?

What for?  The return is going to do the same cast anyway because of the
function return type.

David
