From: Dave Hansen <dave@sr71.net>
Subject: Re: [PATCH 1/3] kconfig: consolidate arch-specific seccomp options
Date: Mon, 13 Jan 2014 12:29:12 -0800
Message-ID: <52D44C98.70906@sr71.net>
References: <20140102202014.CA206E9B@viggo.jf.intel.com> <52D44141.4020304@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52D44141.4020304@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 01/13/2014 11:40 AM, Randy Dunlap wrote:
>> > +config SECCOMP
>> > +	bool
>> > +	default y
> Prefer
> 	def_bool y

I've actually got that already in my updated set that I'll send out when
the merge window opens.
