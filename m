From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 18/18] asm-generic: io: define relaxed accessor macros
 unconditionally
Date: Wed, 23 Apr 2014 09:23:27 +0200
Message-ID: <20140423072327.GA1589@ravnborg.org>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
 <1397742261-15621-19-git-send-email-will.deacon@arm.com>
 <5356782A.9050809@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5356782A.9050809@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

> But I expect that all archs should use asm-generic/io.h to clean
> architecture io.h exactly I have done it for Microblaze.
I took a quick look at sparc32 - doing this is a nice cleanup.
Thanks for the hint.

	Sam
