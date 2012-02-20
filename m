From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 13/21] mn10300: Use generic posix_types.h
Date: Mon, 20 Feb 2012 21:12:03 +0000
Message-ID: <14069.1329772323@redhat.com>
References: <1328677745-20121-14-git-send-email-hpa@zytor.com> <1328677745-20121-1-git-send-email-hpa@zytor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328677745-20121-14-git-send-email-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
List-Id: linux-arch.vger.kernel.org

H. Peter Anvin <hpa@zytor.com> wrote:

> From: "H. Peter Anvin" <hpa@zytor.com>
> 
> Change the mn10300 architecture to use <asm-generic/posix_types.h>.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>

The deletion of part of the user API does not appear to cause a problem.

Acked-by: David Howells <dhowells@redhat.com>
