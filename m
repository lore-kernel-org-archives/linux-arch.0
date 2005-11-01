Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17254.46523.698248.169639@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 11:24:27 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/20] inflate: lindent and manual formatting changes
In-Reply-To: <2.196662837@selenic.com>
References: <2.196662837@selenic.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Matt,

My concern about this series of patches is that it will make it harder
to keep the kernel zlib in sync with the upstream zlib.

Are you signing up to track the upstream zlib and apply any changes
made there to the kernel version, for the forseeable future?

Paul.
