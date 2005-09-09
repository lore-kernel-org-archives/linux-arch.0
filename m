Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 9 Sep 2005 01:04:10 -0700
From: Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] Consistently use the name asm-offsets.h
Message-Id: <20050909010410.1cefe27f.pj@sgi.com>
In-Reply-To: <4320B69D.5010901@didntduck.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
	<4320B69D.5010901@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Brian Gerst <bgerst@didntduck.org>
Cc: tony.luck@intel.com, sam@ravnborg.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Brian wrote:
> The right fix is to get rid of that god-awful circular dependency on 
> offset.h

Just try making such a patch.  I double triple dare you.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
