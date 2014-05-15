From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 17/25] parisc: Add 32 bit time_t and clock_t
Date: Wed, 14 May 2014 17:34:56 -0700
Message-ID: <53740BB0.1050708@zytor.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <1399971966-4598-1-git-send-email-lftan@altera.com> <53727DE8.7000105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53727DE8.7000105@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lftan.linux@gmail.com, cltang@codesourcery.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/13/2014 01:17 PM, Helge Deller wrote:
> 
> We can't use CONFIG_64BIT for a userspace header file. Please use 
> #if !defined(__LP64__)
> instead.
> But even then I'm not sure if it's all correct...
> 

__u64 (or __s64) works fine in that case.

	-hpa
